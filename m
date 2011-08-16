From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Aug 2011 16:48:57 +0200
Subject: Fwd: [GIT PULL] [3.2] Please pull tegra boards for 3.2
In-Reply-To: <CAOesGMhFi0fsVdTe0ThhF636tqUhiWk7oZ41QKmL4dd3TcQ4_g@mail.gmail.com>
References: <CAOesGMjHN-pvVfMN0o3AD238m8wEiRS-D4ArjV_2VAGTuwPfBw@mail.gmail.com>
	<CAOesGMhFi0fsVdTe0ThhF636tqUhiWk7oZ41QKmL4dd3TcQ4_g@mail.gmail.com>
Message-ID: <201108161648.58250.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 14 August 2011, Olof Johansson wrote:
> 
> Hi Arnd,
> 
> Please pull the first set of tegra/board patches for 3.2:
> 
> 
> The following changes since commit e6a99d312687a42c077a9b8cb5e757f186edb1b9:
> 
>  Merge branch 'slab/urgent' of
> git://git.kernel.org/pub/scm/linux/kernel/git/penberg/slab-2.6
> (2011-08-09 08:42:16 -0700)
> 
> are available in the git repository at:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git boards-for-3.2
> 

Hi Olof,

The contents all look good, but I'm undecided whether we should have
branches that are not based on a -rc release. In your case, it's
halfway between -rc1 and -rc2.

Do others have an opinion? If we decide to take development branches
only when they are based on a proper -rc, I'll do the simple rebase
of the patches and push them out, otherwise I'll push them as they are.

	Arnd
