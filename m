From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Apr 2016 11:53:57 +0100
Subject: Applied "ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver" to the asoc tree
In-Reply-To: <1461061984.28704.8.camel@mtksdaap41>
References: <E1asSQc-0004NY-44@debutante> <1461061984.28704.8.camel@mtksdaap41>
Message-ID: <20160419105357.GR3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 06:33:04PM +0800, PC Liao wrote:

> Thanks for your approval.
> But this patch depends on [1].
> I think it also needs to apply [1], otherwise this patch will build
> fail.
> Or, do I need to upload new version again?

> [1] https://patchwork.kernel.org/patch/5671961/ ("ASoC: core: export
> snd_soc_get_dai_name")

Ugh, dropped.  Please put administritive stuff like this after the ---
as covered in SubmittingPatches, that helps it get noticed.  What it
looks like you should be doing here is putting this in a subnode for
capture.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/c97d4e6d/attachment.sig>
