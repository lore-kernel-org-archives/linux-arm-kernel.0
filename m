From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 May 2018 14:58:36 +0100
Subject: [PATCH v2 08/13] ASoC: pxa: remove the dmaengine compat need
In-Reply-To: <20180524070703.11901-9-robert.jarzmik@free.fr>
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
 <20180524070703.11901-9-robert.jarzmik@free.fr>
Message-ID: <20180524135836.GR4828@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 09:06:58AM +0200, Robert Jarzmik wrote:
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180524/f0c21ccd/attachment-0001.sig>
