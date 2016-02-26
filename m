From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Feb 2016 21:25:04 +0900
Subject: [PATCH 1/2] spi: sun4i: add DMA support
In-Reply-To: <1456466217-6793-2-git-send-email-plaes@plaes.org>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
Message-ID: <20160226122504.GR18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 07:56:56AM +0200, Priit Laes wrote:
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> This patch adds support for 64 byte or bigger transfers on the
> sun4i SPI controller. Said transfers will be performed via DMA.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> Tested-by: Michal Suchanek <hramrach@gmail.com>
> Tested-by: Priit Laes <plaes@plaes.org>
> ---

You *must* sign off any patches you are sending, please see
SubmittingPatches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/ead9de10/attachment.sig>
