From: cjb@laptop.org (Chris Ball)
Date: Mon, 18 Jul 2011 21:51:28 -0400
Subject: [PATCH v3 0/4] Add device tree probe for sdhci-esdhc-imx
In-Reply-To: <20110710013708.GA14492@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Sun, 10 Jul 2011 09:37:09 +0800")
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
	<m2pqljje3w.fsf@bob.laptop.org>
	<20110710013708.GA14492@S2100-06.ap.freescale.net>
Message-ID: <m262mzavhb.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn, Sascha,

On Sat, Jul 09 2011, Shawn Guo wrote:
>> > Shawn Guo (4):
>> >       mmc: sdhci-esdhc-imx: do not reference platform data after probe
>> >       mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
>> >       mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
>> >       mmc: sdhci-esdhc-imx: add device tree probe support
>> 
>> These don't apply against mmc-next -- what is your tree based on?
>> 
> It's based on linux-next with following patch applied.
>
> [PATCH v4 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
> write_protect support for mx5
> http://permalink.gmane.org/gmane.linux.kernel.mmc/8748
>
> You applied the 3 of 4 patches in that series, and expect Sascha to
> send this one through his tree after you send those 3.

I see.  In that case, either Sascha can send this new series with my:

Acked-by: Chris Ball <cjb@laptop.org>

or I'll send it as a second pull request after Sascha sends [4/4].

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
