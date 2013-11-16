From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Nov 2013 09:29:44 +0000
Subject: [PATCH 14/31] ASoC: dmaengine: support deferred probe for DMA
 channels
In-Reply-To: <1384548866-13141-15-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-15-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131116092944.GC15393@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:09PM -0700, Stephen Warren wrote:

> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.

Acked-by: Mark Brown <broonie@linaro.org>

but please do provide the branch (ideally just the ASoC core stuff)
since other drivers ought to be being enhanced to use this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/e07195ff/attachment.sig>
