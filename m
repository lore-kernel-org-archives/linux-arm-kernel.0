From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 16:15:20 +0000
Subject: [PATCH v2 11/17] ASoC: fsl: create fsl_utils to accommodate the
 common functions
In-Reply-To: <4F54E065.8060905@freescale.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-12-git-send-email-shawn.guo@linaro.org>
 <20120305144920.GR3224@opensource.wolfsonmicro.com>
 <4F54E065.8060905@freescale.com>
Message-ID: <20120305161520.GT3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 09:48:53AM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> > This doesn't seem at all Freescale specific, it should be a generic
> > helper, and in fact there already is one - the machine driver can set
> > codec_of_node in the card structure to point to the device node and then
> > the core should figure out binding to the device for you.  If it doesn't
> > we should fix the core.

> Can we do that in another patch set, so that it doesn't hold up Shawn's
> work?  All this patch does is move the code from one file to another, so
> it's not like he's adding a feature incorrectly.

Well, it shouldn't be much effort - instead of removing the code just
delete it mostly - and there's other issues that need to be looked at
anyway.  There's also the arch/arm stuff that needs review...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/614b0279/attachment.sig>
