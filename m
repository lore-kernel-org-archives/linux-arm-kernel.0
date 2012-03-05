From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 20:36:32 +0000
Subject: [PATCH v2 01/17] ASoC: imx: move eukrea audmux call into ASoC
 machine driver
In-Reply-To: <CAKGA1b=4X+ccQXjZVa1DYpRYC0NT0A9AqwgG-ApkzboRkC3sJg@mail.gmail.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
 <20120305174612.GY3224@opensource.wolfsonmicro.com>
 <CAKGA1b=4X+ccQXjZVa1DYpRYC0NT0A9AqwgG-ApkzboRkC3sJg@mail.gmail.com>
Message-ID: <20120305203631.GB3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 11:55:07AM -0600, Matt Sealey wrote:
> How will this stand up to an machine audio fabric that, like

"This" would be a lot more meaningful if you'd included some context
in your reply so the reader could tell what you were talking about.

> imx-sgtl5000 going around BSPs and Linaro and so on since the dawn of
> time, supports multiple boards but very different audmux
> configurations? Is this just a stopgap until the DT properly describes
> it?

What are the limitations which you see in the new code?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/d8fa7ac1/attachment.sig>
