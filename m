From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Oct 2016 11:08:12 -0700
Subject: [GIT PULL] ARM: uniphier: fixes for v4.9
In-Reply-To: <CAK7LNATGyfiYYsxDeyhjerG16MMro--sxCC1nwpCu-9fN9+dBQ@mail.gmail.com>
References: <CAK7LNATGyfiYYsxDeyhjerG16MMro--sxCC1nwpCu-9fN9+dBQ@mail.gmail.com>
Message-ID: <20161029180812.GA4195@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 22, 2016 at 11:28:51PM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Here are some fixes for v4.9.
> It is touching a reset controller driver, but Philipp gave me Acked-by
> for including it in my pull-request.
> 
> 
> Here is a question; do you have a chance to send a pull-request for fixes
> to Linus before -rc4?  In my understanding, pull requests for the next merge
> window are generally required to be based on a tag prior to -rc4.
> In the previous development cycle, I remember the fixes pull-request was
> sent around v4.8-rc7.  In this case, it would be a problem if a fixup commit
> and a new-development commit have a conflict with each other.
> If the first round of fixes pull-request is sent before -rc4, commits for
> the next merge window can be queued up based on -rc4 without any conflicts.

We send periodic pull requests, usually once per -rc (but sometimes we skip
one). These should make it into -rc3.

The base for next merge window should be based on as old a release as
practical, but what you can do is that you can use the fixes branch as the base
if you need to (just don't rebase it).


> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-fixes-v4.9
> 
> for you to fetch changes up to 8e68c65d111a57a4cbe41dc886bb2a1e671e0b6e:
> 
>   arm64: dts: uniphier: change MIO node to SD control node (2016-10-22
> 21:59:21 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM SoC fixes for v4.9
> 
> - Add "select ARCH_HAS_RESET_CONTROLLER" in Kconfig
> - Rename wrongly-named mioctrl to sdctrl

Merged, thanks.


-Olof
