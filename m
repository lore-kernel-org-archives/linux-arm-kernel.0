From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Apr 2018 16:26:32 +0100
Subject: [PATCH 08/15] ASoC: pxa: remove the dmaengine compat need
In-Reply-To: <20180402142656.26815-9-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-9-robert.jarzmik@free.fr>
Message-ID: <20180412152632.GG9929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2018 at 04:26:49PM +0200, Robert Jarzmik wrote:
> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.

Acked-by: Mark Brown <broonie@kernel.org>

If there's no dependency I'm happy to take this for 4.18.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/4ef90da2/attachment.sig>
