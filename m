From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jan 2013 14:06:58 -0800
Subject: [GIT PULL] ux500 fixes for the v3.8 series
In-Reply-To: <CACRpkdYhVbu2S6iD=SRnU1gMRNfau25ihOqoDoXvCrH71seREQ@mail.gmail.com>
References: <CACRpkdYhVbu2S6iD=SRnU1gMRNfau25ihOqoDoXvCrH71seREQ@mail.gmail.com>
Message-ID: <20130128220658.GC7789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 01:40:34PM +0100, Linus Walleij wrote:
> Hi ARM SoC guys,
> 
> here are three fixes for the Ux500 that need to go to the -rc:s.
> 
> Please pull them in!
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:
> 
>   Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)
> 
> are available in the git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-fixes-for-v3.8


Pulled, thanks.

Nit below:

> Steve Zhan (1):
>       ARM: ux500: add spin_unlock(&master_lock).

That's not a great patch subject, but I'm not going to ask a respin just for
it.


-Olof
