From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 4 May 2013 13:58:39 -0400
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <5182C322.3030304@gmail.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130502185322.GA29333@obsidianresearch.com>
 <5182B902.7040908@gmail.com>
 <20130502193510.GA29522@obsidianresearch.com>
 <5182C322.3030304@gmail.com>
Message-ID: <20130504175839.GM31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 09:48:50PM +0200, Sebastian Hesselbarth wrote:
> On 05/02/2013 09:35 PM, Jason Gunthorpe wrote:
> >I have kirkwood HW but I haven't had time to make newer kernels run on
> >it, otherwise I'd test it too :(
> 
> I also have kirkwood HW but that will cut me from email as I use it as
> relay server ;) Maybe I can turn it into a test bed for a while.
> 
> There is also Orion5x and Discovery Innovation (mv78xx0) to be tested.
> 
> @Jason Cooper: I will merge both irqchip and dove patches into one
> patch set. I wasn't earlier because I didn't want the above SoCs to
> slow down patch integration. And I will split dtsi changes into
> separate patches as requested.

Understood.  I'd prefer to keep patches developed together in the same
series, that way, discussions about who is taking what and which patch
depends on what are all in the same thread of the archives.

It's difficult because some series (eg pcie) touch many different areas
and _need_ to be kept together because of the chain of dependencies.
Most other series though, aren't in that situation.

thx,

Jason.
