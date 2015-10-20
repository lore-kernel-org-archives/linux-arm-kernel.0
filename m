From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 20 Oct 2015 12:42:26 +0200
Subject: [PATCH v4 11/22] i2c: core: Probe i2c adapters and devices on
 demand
In-Reply-To: <1441628627-5143-12-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-12-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20151020104226.GA3654@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 02:23:36PM +0200, Tomeu Vizoso wrote:
> When looking up an i2c adapter or device through its OF node, probe it
> if it hasn't already.
> 
> The goal is to reduce deferred probes to a minimum, as it makes it very
> cumbersome to find out why a device failed to probe, and can introduce
> very big delays in when a critical device is probed.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

If the I2C part stays that simple and the core part of the series is
accepted, then:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151020/b805aad5/attachment-0001.sig>
