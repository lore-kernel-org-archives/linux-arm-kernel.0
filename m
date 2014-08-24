From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sun, 24 Aug 2014 15:58:56 -0700
Subject: [GIT PULL] ARM: SoC fixes for 3.17-rc
In-Reply-To: <20140824184035.GA13254@localhost>
References: <20140824184035.GA13254@localhost>
Message-ID: <CA+55aFzW676RhCgu8Wp2SMcnKT2q82_DB9Aof74fwZPuXNtjZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 24, 2014 at 11:40 AM, Olof Johansson <olof@lixom.net> wrote:
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes

Grr. Yes and no.

You didn't really mean for me to pull that branch, you meant for me to
pull your tag "fixes-for-linus".

Where did this fail? Do you still run an old broken git version that
guesses at what the pull target is, and makes sh*t up? Please update
if so.

And if not, how did the tag contents get added to the pull request
despite the pull request not mentioning the tag?

           Linus
