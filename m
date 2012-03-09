From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Mar 2012 11:55:44 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F591B8D.8090705@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
Message-ID: <20120309115540.GE3273@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 02:50:21PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:

> > More importantly, the imx machine drivers to be added working with
> > fsl_ssi will not have this property, as they use new ASoC machine
> > driver binding mechanism.

> I want to see that binding documented in Documentation/devicetree/bindings
> first.

That binding will generally be per machine driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/942ac0dc/attachment-0001.sig>
