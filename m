From: timur@freescale.com (Timur Tabi)
Date: Mon, 5 Mar 2012 09:48:53 -0600
Subject: [PATCH v2 11/17] ASoC: fsl: create fsl_utils to accommodate the
 common functions
In-Reply-To: <20120305144920.GR3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-12-git-send-email-shawn.guo@linaro.org>
 <20120305144920.GR3224@opensource.wolfsonmicro.com>
Message-ID: <4F54E065.8060905@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> This doesn't seem at all Freescale specific, it should be a generic
> helper, and in fact there already is one - the machine driver can set
> codec_of_node in the card structure to point to the device node and then
> the core should figure out binding to the device for you.  If it doesn't
> we should fix the core.

Can we do that in another patch set, so that it doesn't hold up Shawn's
work?  All this patch does is move the code from one file to another, so
it's not like he's adding a feature incorrectly.

-- 
Timur Tabi
Linux kernel developer at Freescale
