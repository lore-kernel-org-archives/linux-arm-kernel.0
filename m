From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 21 Jan 2016 01:30:47 +0100
Subject: [PATCH 0/8] rtc: max77686: Extend driver and add max77802 support
In-Reply-To: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
References: <1453310088-29985-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20160121003047.GF3367@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/01/2016 at 14:14:40 -0300, Javier Martinez Canillas wrote :
> One thing that I'm not sure is how to handle bisectability, in patch #5
> there will be two drivers that matches "rtc-max77802". So I don't know
> if I should use a different platform_device_id name and change in the
> same patch that max77802 is removed or if this is not a big deal so the
> patches could stay as is.
> 

I'm fine with those patches as is.

> I believe all patches should go through the RTC tree with proper acks or
> wait until the RTC patches land to pick the defconfig changes.
> 

I think Olof would prefer the last patches to go through arm-soc.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
