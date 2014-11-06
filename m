From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Nov 2014 12:52:55 +0000
Subject: [PATCH] spi: pxa2xx: toggle clocks on suspend if not disabled by
 runtime PM
In-Reply-To: <1415272109-24970-1-git-send-email-dbaryshkov@gmail.com>
References: <1415272109-24970-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141106125255.GE8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 02:08:29PM +0300, Dmitry Eremin-Solenikov wrote:
> If PM_RUNTIME is enabled, it is easy to trigger the following backtrace
> on pxa2xx hosts:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/376cb6e9/attachment.sig>
