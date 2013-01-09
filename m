From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 8 Jan 2013 18:57:08 -0800
Subject: [GIT PULL] ARM: arm-soc fixes for 3.8-rc
In-Reply-To: <20130108184920.GA1258@quad.lixom.net>
References: <20130108184920.GA1258@quad.lixom.net>
Message-ID: <CA+55aFxxv2h8TAxvwprdQEpaz4Ww5ime+t8rmpjnjv2t-mWYaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 8, 2013 at 10:49 AM, Olof Johansson <olof@lixom.net> wrote:
>
> A slightly larger delta than I'd ideally want by now, in part due to some
> of the OMAP PM fixes that's adding a bit of code. I decided to include
> it instead of push it to 3.9, but from here on out we'll be stricter.

Ugh. Not only that, but:

>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes

you have both a branch called "fixes" and a tag called "fixes".
Ambiguous. And when you ask me to pull like the above, it actually
picks the branch, not the tag.

Don't do this. Either use the unambiguous name ("tags/fixes" rather
than just "fixes") or don't push out branches and tags that have the
same name.

                     Linus
