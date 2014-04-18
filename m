From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Apr 2014 16:08:04 +0100
Subject: [PATCH v2 1/2] regmap: add reg_read/reg_write callbacks to
 regmap_bus struct
In-Reply-To: <1397727612-32103-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1397727612-32103-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397727612-32103-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140418150804.GX12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 11:40:11AM +0200, Boris BREZILLON wrote:
> Some busses do not support sending/receiving multiple registers in one go.
> Such kind of busses just unpack the registers that have been previously
> packed by the regmap core or pack registers that will be later unpacked by
> the core code.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140418/86311eb4/attachment.sig>
