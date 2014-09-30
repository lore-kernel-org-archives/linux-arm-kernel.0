From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 30 Sep 2014 08:07:09 +0200
Subject: [PATCH 1/2 v2] i2c: cros-ec-tunnel: Add of match table
In-Reply-To: <5429E982.4050509@collabora.co.uk>
References: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1411114093-3505-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <20140929205922.GB2758@katana> <5429E982.4050509@collabora.co.uk>
Message-ID: <20140930060709.GB1325@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Doug posted a patch [0] to fix the issue you are reporting but it was not
> picked. I tested that the patch applies on top of linux-next + the latest
> cros_ec cleanups (that includes a patch for this i2c driver and was taken
> by Lee. So I think is safe for you take Doug's patch through your tree
> since it seems to not cause any conflict with the mfd tree.

OK, thanks for the heads up. I picked it.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/6e67a5f2/attachment.sig>
