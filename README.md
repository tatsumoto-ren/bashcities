# bashcities

[![AUR version](https://img.shields.io/aur/version/bashcities)](https://aur.archlinux.org/packages/bashcities)
[![Chat](https://img.shields.io/badge/chat-join-green)](https://tatsumoto-ren.github.io/blog/join-our-community.html)
![GitHub](https://img.shields.io/github/license/tatsumoto-ren/bashcities)

> A neocities client that actually works.

I use [neocities](https://neocities.org/) to host some sites.
One day the official CLI client stopped working completely,
so I wrote this one in bash.

## Setup

0) Install `bashcities` somewhere. Example:
```
$ git clone 'https://github.com/tatsumoto-ren/bashcities.git' ~/.local/share/neocities
$ ln -s ~/.local/share/neocities/bashcities ~/.local/bin/bashcities
```
1) Grab your API Key.
Go to https://neocities.org/settings/,
click "Manage Site Settings" > "API Key".
Usually it looks like this: `da77c3530c30593663bf7b797323e48c`.
2) Initialize a new profile.
Run `bashcities init new_profile`.
`new_profile` can be any string (without spaces).
It doesn't have to be equal to your site name.
3) Edit your profile settings.
Run `vim ~/.config/neocities/new_profile`
Specify the directory of your site and the API key.

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

### Backup your site

```
$ neo download
```

Downloads a full copy of your site
and saves it to a new folder in the directory of the site.
