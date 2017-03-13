From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Mar 2017 16:06:57 -0700
Subject: [GIT PULL] Gemini device tree base
In-Reply-To: <CACRpkdb1XPpY02_40P2cu941eaMbdMSLQgFJb_v3JRB9yfBSTQ@mail.gmail.com>
References: <CACRpkdb1XPpY02_40P2cu941eaMbdMSLQgFJb_v3JRB9yfBSTQ@mail.gmail.com>
Message-ID: <20170313230657.GK13064@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 12, 2017 at 12:26:23PM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this complements the previous pull request patching the Gemini
> machine into a device tree platform by providing the corresponding
> device tree changes.
> 
> The watchdog bindings are included since (I think) the watchdog
> maintainer simply missed them when merging the driver in the last
> merge window. No big deal, but if you prefer that I take them out
> and ask the watchdog maintainer to merge them separately we
> can do that, it just seems bureaucratic.
> 
> Please pull this in as you find best.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/gemini-dts-base
> 
> for you to fetch changes up to 6ae4d211ab066ad3b808a2b7f0851837c44f495d:
> 
>   ARM: dts: add watchdog to the Gemini (2017-03-12 12:18:29 +0100)
> 
> ----------------------------------------------------------------
> Base patches for Gemini device trees:
> 
> - Bindings for the platform.
> 
> - Device trees for everything that was available as board
>   files previously.
> 
> - New device tree for my target system SQ201.
> 
> - Device tree bindings for the watchdog. The driver was merged
>   to the watchdog subsystem so this was probably just missed
>   by the maintainer, and it is ACKed by Rob Herring.

Merged, thanks!


-Olof
