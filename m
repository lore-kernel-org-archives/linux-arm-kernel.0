From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 21 Jun 2013 17:03:23 +0200
Subject: [PATCH v3 4/4] ARM: dts: mvebu: Introduce a new compatible
 string for mv64xxx-i2c
In-Reply-To: <20130621145629.GQ31667@titan.lakedaemon.net>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
 <1371821529-13791-5-git-send-email-gregory.clement@free-electrons.com>
 <20130621140707.GO31667@titan.lakedaemon.net>
 <51C46001.30500@gmail.com>
 <20130621145629.GQ31667@titan.lakedaemon.net>
Message-ID: <20130621150323.GA3450@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > from a quick check of the patch set (which you forgot to send to LKML)
> > I am wondering why you didn't update the of matches struct with the new
> > compatible for "marvell,mv78230-i2c"? This will save you from still
> > having "marvell,mv64xxx-i2c" as additional compatible to match device
> > and driver. With that the above should also be s/and/or/.
> 
> agreed, good point.
> 
> Gregory,
> 
> I'm sending the last PRs for mvebu today.  I'll include this one with my
> suggestion and Sebastian's if you're ok with it.  That means you'll have
> to respin the series for the i2c folks.  Does that work for you?

No hurry, please. Most of the patches are 3.12 material anyhow, so we
can as well just wait until the I2C patches are okay and then update the
dts later.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/0fc4b799/attachment.sig>
