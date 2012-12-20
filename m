From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 20 Dec 2012 08:49:30 -0800
Subject: [GIT PULL v2] ARM: arm-soc fixes for 3.8
In-Reply-To: <20121220163814.GA29557@quad.lixom.net>
References: <20121220163814.GA29557@quad.lixom.net>
Message-ID: <CA+55aFxL47wxTyTzLdnoFV=trnrMAz=_7rhsQFjb+K_mvTCa9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 8:38 AM, Olof Johansson <olof@lixom.net> wrote:
>
> One of the sunxi patches from the last pull request was misapplied (I
> realized what happened -- git am -s didn't apply cleanly so I had done it
> through regular patch, thus not catching the renames properly). Here's
> a fresh version of the pull request with a couple more OMAP and Samsung
> patches included.

Argh!

I pulled your earlier branch due to Tony's ack, and now you're
re-created that branch with new pulls (effectively rebasing it).

Don't do things like this to me.

                Linus
