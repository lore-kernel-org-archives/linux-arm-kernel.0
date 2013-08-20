From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 20 Aug 2013 21:07:14 +0200
Subject: [PATCH v5 0/3] i2c-mv64xxx: Fixes and new feature for controlers
 embedded in Aramda XP
In-Reply-To: <5213979B.4050306@free-electrons.com>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
 <5213979B.4050306@free-electrons.com>
Message-ID: <20130820190714.GB24466@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Jason Cooper drooped the third patch as it conflicted with a patch from
> Maxime Ripard which adds the AllWinner support. Olof also asked a formal
> acked-by from a device tree maintainer even if we already answer to
> Mark Rutland request.
> 
> Olof also requested that you take the binding update, so I am going to send
> a new version of this patch set with the last patch split in two parts.

Yeah, I wondered about the binding already being accepted when the
driver review was not done.

> As explained earlier today, unless you really want I use be32_to_cpu in the
> mv64xxx_i2c_offload_msg() I won't change anything else.

I found some more (minor) issues. Expect a review by tomorrow evening.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130820/a803dbd7/attachment.sig>
