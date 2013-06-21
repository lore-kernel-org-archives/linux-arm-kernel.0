From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Jun 2013 11:06:29 -0400
Subject: [PATCH v3 4/4] ARM: dts: mvebu: Introduce a new compatible
 string for mv64xxx-i2c
In-Reply-To: <20130621150323.GA3450@katana>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
 <1371821529-13791-5-git-send-email-gregory.clement@free-electrons.com>
 <20130621140707.GO31667@titan.lakedaemon.net>
 <51C46001.30500@gmail.com>
 <20130621145629.GQ31667@titan.lakedaemon.net>
 <20130621150323.GA3450@katana>
Message-ID: <20130621150629.GR31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 05:03:23PM +0200, Wolfram Sang wrote:
> 
> > > from a quick check of the patch set (which you forgot to send to LKML)
> > > I am wondering why you didn't update the of matches struct with the new
> > > compatible for "marvell,mv78230-i2c"? This will save you from still
> > > having "marvell,mv64xxx-i2c" as additional compatible to match device
> > > and driver. With that the above should also be s/and/or/.
> > 
> > agreed, good point.
> > 
> > Gregory,
> > 
> > I'm sending the last PRs for mvebu today.  I'll include this one with my
> > suggestion and Sebastian's if you're ok with it.  That means you'll have
> > to respin the series for the i2c folks.  Does that work for you?
> 
> No hurry, please. Most of the patches are 3.12 material anyhow, so we
> can as well just wait until the I2C patches are okay and then update the
> dts later.

Ok, thanks for the heads up.  I'll put this in my v3.12 stack.

thx,

Jason.
