From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 02 May 2013 21:48:50 +0200
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <20130502193510.GA29522@obsidianresearch.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130502185322.GA29333@obsidianresearch.com> <5182B902.7040908@gmail.com>
 <20130502193510.GA29522@obsidianresearch.com>
Message-ID: <5182C322.3030304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2013 09:35 PM, Jason Gunthorpe wrote:
> I have kirkwood HW but I haven't had time to make newer kernels run on
> it, otherwise I'd test it too :(

I also have kirkwood HW but that will cut me from email as I use it as
relay server ;) Maybe I can turn it into a test bed for a while.

There is also Orion5x and Discovery Innovation (mv78xx0) to be tested.

@Jason Cooper: I will merge both irqchip and dove patches into one
patch set. I wasn't earlier because I didn't want the above SoCs to
slow down patch integration. And I will split dtsi changes into
separate patches as requested.

Sebastian
