From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 09:52:49 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140825150900.GB21020@skynet.be>
References: <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825150900.GB21020@skynet.be>
Message-ID: <20140826075247.GC17263@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 05:09:00PM +0200, Luc Verhaegen wrote:
> On Mon, Aug 25, 2014 at 05:05:04PM +0200, Thierry Reding wrote:
> > 
> > No. simplefb just wants to write to some memory that hardware has been
> > set up to scan out. The platform requires that the clocks be on.
> 
> Simplefb also requires that the memory is there and is persistent. Fine 
> for discrete graphics cards, fine for rpi where most things are hidden 
> from the ARM core anyway, not so fine for anybody else.

I don't understand. This patch series isn't changing anything about the
memory aspects of the driver yet it's working for you on sunxi, isn't
it? So it can't be all that broken.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/9b9b9f75/attachment.sig>
