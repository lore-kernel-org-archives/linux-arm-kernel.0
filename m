From: chris@printf.net (Chris Ball)
Date: Thu, 22 May 2014 13:05:16 +0100
Subject: [GIT PULL] MMC updates for mmc-next for 3.16, take 3
In-Reply-To: <CAPDyKFo44fucVebB3f_qby1iWqjyq5P4XPAyD6og5ZWpqgO4=A@mail.gmail.com>
 (Ulf Hansson's message of "Thu, 22 May 2014 12:49:11 +0200")
References: <CAPDyKFo44fucVebB3f_qby1iWqjyq5P4XPAyD6og5ZWpqgO4=A@mail.gmail.com>
Message-ID: <86zjiaqarn.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Thu, May 22 2014, Ulf Hansson wrote:
> Here are a third and final collection of patches for 3.16.
>
> I have as you and I discussed (off list), collected the patches from
> Russell's sdhci patchset. I needed to resolve some conflicts while
> applying them, but it was manageable. I also omitted the patch which
> was reported to caused problem with eMMC, (mmc: sdhci: hack up driver
> to make it more compliant with UHS-1).

Pulled, but:

drivers/mmc/host/sdhci.c: In function ?sdhci_set_uhs_signaling?:
drivers/mmc/host/sdhci.c:1432:12: error: ?ios? undeclared (first use
in this function)
  else if ((ios->timing == MMC_TIMING_UHS_DDR50) ||
            ^
drivers/mmc/host/sdhci.c:1432:12: note: each undeclared identifier is
reported only once for each function it appears in
make[3]: *** [drivers/mmc/host/sdhci.o] Error 1

- Chris.
-- 
Chris Ball   <http://printf.net/>
