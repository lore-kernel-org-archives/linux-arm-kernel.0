From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 8 Jan 2014 12:23:59 +0100
Subject: [PATCH 04/04 v2] ARM: shmobile: Genmai I2C-over-GPIO support
In-Reply-To: <20140108004157.GH5136@verge.net.au>
References: <20131217050232.727.9552.sendpatchset@w520>
 <20131217050324.727.61701.sendpatchset@w520>
 <20131217163435.GC7071@katana> <20140108004157.GH5136@verge.net.au>
Message-ID: <20140108112359.GA2669@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> could you clarify the status of this patch for me?
> 
> I believe it is reverted by "[PATCH V2 4/5] arm: shmobile: genmai: adapt
> dts to use native i2c driver".
> 
> I'm fine with applying both patches at some point. But perhaps
> we can skip some dependencies by just applying a squashed version?

If we keep this patch and my one on top of it, we need the PFC series.
If we skip this patch and use my native I2C right from the beginning, we
can skip the PFC series and have i2c support right away. I'd prefer the
latter. I am about to push a branch to my tree that does the latter
these minutes.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/b64c65e6/attachment.sig>
