From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Sep 2014 15:39:56 +0100
Subject: [PATCH 2/2] spi: davinci: support adding delay between
 transmission
In-Reply-To: <540DAF91.6090002@ti.com>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
 <1408634706-5762-3-git-send-email-grygorii.strashko@ti.com>
 <20140821182035.GM24407@sirena.org.uk> <53F74695.3010902@ti.com>
 <20140822150644.GX24407@sirena.org.uk> <5409C704.5070303@ti.com>
 <20140906143113.GI2601@sirena.org.uk> <540DAF91.6090002@ti.com>
Message-ID: <20140908143956.GL4015@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 04:30:57PM +0300, Grygorii Strashko wrote:

> I'll split this patch and first introduce WDELAY, C2TDELAY, T2CDELAY
> (with updated documentation).
> The only question is - Should they be somehow common or specific for spi-davinci?

If they don't have any impact on the device at the remote end of the
link then making them device specific is fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140908/bc5f0571/attachment.sig>
