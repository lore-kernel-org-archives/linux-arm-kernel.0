From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Mar 2016 13:59:31 +0000
Subject: [PATCH 3/4] arm64: dts: marvell: Clean up armada-7040-db
In-Reply-To: <20160324133723.GB15624@lunn.ch>
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
 <1458771861-12392-4-git-send-email-afaerber@suse.de>
 <20160324091832.0060c907@free-electrons.com>
 <87oaa4npbk.fsf@free-electrons.com>
 <20160324114037.1204b46e@free-electrons.com>
 <20160324133723.GB15624@lunn.ch>
Message-ID: <20160324135931.GE26573@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 02:37:23PM +0100, Andrew Lunn wrote:
> > > I agree that converting the Marvell Armada 32-bits SoCs would produce a
> > > lot of churn. But if some binding are common there is no file at all are
> > > in common, so we could use this solution for the 64 bits SoCs only.
> > 
> > Yes, we could. I'm fine with it. I was merely pointing out that it is
> > moving away from our 32 bits way of doing things.
> 
> Sebastian spent a while converting dove and kirkwood to this
> scheme. Most boards have i2c, nand, eth, and mdio properties
> represented link this.
> 
> There are no many 64 bit boards, so now is the time to make the
> change...

Agreed.

thx,

Jason.
