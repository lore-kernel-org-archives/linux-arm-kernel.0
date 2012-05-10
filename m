From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 17:17:27 +0800
Subject: [PATCH 2/6] ASoC: mxs: use devm_clk_get for mxs_saif_probe
In-Reply-To: <20120510091332.GF3908@opensource.wolfsonmicro.com>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
 <1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
 <20120510091332.GF3908@opensource.wolfsonmicro.com>
Message-ID: <CAAQ0ZWRtwwpToK9J5EbJvRrKnzGn6SrkDgNumat1b3vAS4ytUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 May 2012 17:13, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, May 10, 2012 at 04:42:09PM +0800, Shawn Guo wrote:
>> Use devm_clk_get for mxs_saif_probe to ease the cleanup.
>
> Please stop submitting devm_clk_get() changes until it's in mainline, as
> I've said with all the similar changs this can't be applied until that
> API can be merged up into ASoC.

Russell's clkdev branch will show up in arm-soc as a dependency
branch.  So if you are ok with the series go through arm-soc, we will
be fine.

Regards,
Shawn
