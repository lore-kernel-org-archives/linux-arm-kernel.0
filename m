From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Apr 2015 10:00:12 +0200
Subject: [RFC PATCH 1/3] PCI: host: designware: support ARM64
In-Reply-To: <552F4DF3.6000402@hisilicon.com>
References: <1429077843-184462-1-git-send-email-wangzhou1@hisilicon.com>
 <5374927.lpgzSJ47Sk@wuerfel> <552F4DF3.6000402@hisilicon.com>
Message-ID: <4046182.mBfkEVqZjc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 April 2015 13:51:47 Zhou Wang wrote:
> > 
> > Again, separate patch.
> > 
> > I've just tried to come up with a nicer way of doing all this, can
> > you try the experimental patch below?
> > 
> >       Arnd
> > 
> 
> Sure, I will try the patch below. I think it can work well in my Hisilicon
> D02 board. But I don't have arm32 PCIe related board to test. It will be helpful
> if someone could help to test it.

Ok, please incorporate the patch into your series then and make sure it
builds fine on both 32-bit (multi_v7_defconfig) and 64-bit ARM. If we
get consensus on the code, I'm sure we can find testers.

	Arnd
