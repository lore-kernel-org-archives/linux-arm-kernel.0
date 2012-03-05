From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 5 Mar 2012 11:55:07 -0600
Subject: [PATCH v2 01/17] ASoC: imx: move eukrea audmux call into ASoC
 machine driver
In-Reply-To: <20120305174612.GY3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
 <20120305174612.GY3224@opensource.wolfsonmicro.com>
Message-ID: <CAKGA1b=4X+ccQXjZVa1DYpRYC0NT0A9AqwgG-ApkzboRkC3sJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

How will this stand up to an machine audio fabric that, like
imx-sgtl5000 going around BSPs and Linaro and so on since the dawn of
time, supports multiple boards but very different audmux
configurations? Is this just a stopgap until the DT properly describes
it?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.



On Mon, Mar 5, 2012 at 11:46 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Mar 05, 2012 at 10:30:49PM +0800, Shawn Guo wrote:
>> It moves eukrea audmux configuration call from board file into ASoC
>> machine driver eukrea-tlv320, so that it gets aligned wm1133-ev1 and
>> mx27vis-aic32x4, and more importantly it will ease the moving of audmux
>> into sound/soc/imx as a platform driver later.
>
> Sascha, this and the second patch look totally uncontroversial - can we
> just apply them now so we don't need to keep reviewing them?
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
