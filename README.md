# bashcities

[![AUR](https://img.shields.io/badge/AUR-install-blue)](https://aur.archlinux.org/packages/bashcities)
[![Chat](https://img.shields.io/badge/chat-join-green)](https://tatsumoto-ren.github.io/blog/join-our-community.html)
![GitHub](https://img.shields.io/github/license/tatsumoto-ren/bashcities)

> A neocities client that actually works.

I use [neocities](https://neocities.org/) to host some sites.
One day the official CLI client stopped working completely,
so I wrote this one in bash.

## Installation

### Arch Linux and pacman-based distros

If your distribution is based on Arch Linux,
you can install the [AUR package](https://aur.archlinux.org/packages/bashcities)
and skip to [Setup](#setup).

### Other distros

If you want to package this program for your distro and know how to do it,
please create a pull request.

<details>

<summary>Manual installation</summary>

1) Install dependencies.
   The dependencies are very basic and I expect that you already have them.

   * `bash`
   * `python`
   * `curl`
   * `git` (recommended, but optional)
2) Save the executable somewhere and make sure it's in your `PATH`.
   For example, like this.

   ```
   $ git clone 'https://github.com/tatsumoto-ren/bashcities.git' ~/.local/share/neocities
   $ ln -s ~/.local/share/neocities/bashcities ~/.local/bin/bashcities
   ```

</details>

## Setup

1) Grab your API Key.
   Go to the [Neocities settings](https://neocities.org/settings/),
   click "Manage Site Settings" > "API Key".
   Usually it looks like this: `da77c3530c30593663bf7b797323e48c`.
1) Initialize a new profile.
   Run `bashcities init new_profile`.
   `new_profile` can be any string (without spaces).
   It doesn't have to be equal to your site name.
1) The profile file will be saved in `~/.config/neocities/`.
   Edit it and specify the directory of your site and the API key.

Variables in the config file:

* `site_directory`. The path to the local folder that contains your site.
* `api_key`. This key is required for authentication on Neocities.
* `ignore_regex`. A regular expression that defines files to be ignored.
   They won't be uploaded to the remote.
* `n_concurrent_tasks`. Uploading files one by one can take time.
   You can choose to upload multiple files at the same time,
   and it will make updating faster.

## Running

When you run `bashcities`, you have to specify a profile name.

```
$ bashcities --profile my_site
$ bashcities -p my_site
```

You may want to add this command as an alias to your `~/.bashrc` (or `~/.zshrc`, etc.).

```
alias neo='bashcities --profile my_site'
```

To print a help page, run `bashcities --help`.

## Usage

Your site has to be managed by `git`.
If it's not, initialize a git repository or use the `--no-git` switch.

If you manage your site with `git`,
`bashcities` will not upload files that you haven't added to the index.
This behavior resembles that of the official CLI client.

### Update your site

```
$ neo push
```

Uploads all files that differ from the remote.
It skips files that haven't been changed.
Files that aren't present locally are deleted from the remote.
Changes that haven't been committed aren't pushed.

### See status

```
$ neo status
```

Lists all files that differ from the remote.
These files will be updated on the next `push`.

### List files

```
$ neo list
```

List all files on the remote.

### Upload a new file

```
$ neo upload file.html
```

Uploads `file.html` to the remote.

```
$ neo upload 'articles/about.html'
```

Directory structure is preserved.

### Delete a file

```
$ neo delete 'articles/about.html'
```

Deletes `file.html` from the remote.

### Backup your site

```
$ neo download
```

Downloads a full copy of your site
and saves it to a new folder in the directory of the site.
