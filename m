From: john@metanate.com (John Keeping)
Date: Wed, 22 Feb 2017 13:43:14 +0000
Subject: [RESEND PATCH v7 0/7] Rockchip dw-mipi-dsi driver
In-Reply-To: <20170221153918.GA25168@art_vandelay>
References: <1487577744-2855-1-git-send-email-zyw@rock-chips.com>
 <20170221153918.GA25168@art_vandelay>
Message-ID: <20170222134314.016a4940.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Feb 2017 10:39:18 -0500, Sean Paul wrote:

> On Mon, Feb 20, 2017 at 04:02:16PM +0800, Chris Zhong wrote:
> > Hi all
> > 
> > [Resend this v7 version series, since there are 5 mails have gone missing, last
> > week]
> > 
> > This version does not change the existing v6 patches, just to add the
> > "bandwidth fix" patch back, since we really need it.
> > 
> > This patch serial is for RK3399 MIPI DSI. The MIPI DSI controller of
> > RK3399 is almost the same as RK3288, except a little bit of difference
> > in phy clock controlling and port id selection register. These patches
> > add RK3399 support and the power domain support.
> > 
> > And these patches base on John Keeping's v3 patches[0], it fixes many bugs,
> > they have been tested on rk3288 evb board.  
> 
> Do we have an ETA on when John is planning on respinning his patchset based on
> review feedback?

I have all of the changes queued but I was hoping to find some time to
test the latest version before sending it out; unfortunately everything
else is more important at the moment.  If you're happy with the caveat
that the latest changes are build tested only I can probably send it
out this afternoon.


John
