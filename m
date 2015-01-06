From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 6 Jan 2015 14:37:53 +0100
Subject: [PATCH v3 0/2] ARM: mediatek: Add driver for Mediatek I2C
 controller
In-Reply-To: <1418352022.4994.44.camel@mtksdaap41>
References: <1416821928-11453-1-git-send-email-xudong.chen@mediatek.com>
 <20141124121555.GG3733@katana>
 <1417096856.12707.59.camel@mtksdaap41>
 <20141127164536.GC5667@katana>
 <1418352022.4994.44.camel@mtksdaap41>
Message-ID: <20150106133753.GA3754@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> We've started upstream work for MT8173[1].
> 
> We've fixed these issues for new SoC, and we believe it is fully I2C
> compatible now. We'll add mt8173 support to this driver, so this driver
> will support both fully I2C compatible SoC and the current one.

>From what you tell, I'd rather add the MT8173 support incrementally.
Let's get first the limited support properly implemented, then add
another controller.

I'll send out my draft for describing the quirks later today.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/7564d3c5/attachment-0001.sig>
