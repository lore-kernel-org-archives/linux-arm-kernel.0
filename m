From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 05 Jun 2015 18:17:09 +0200
Subject: [PATCH v3 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <1744325.yNd0r8SV4R@diego>
References: <1433517104-7595-1-git-send-email-wxt@rock-chips.com>
 <1433517104-7595-2-git-send-email-wxt@rock-chips.com>
 <1744325.yNd0r8SV4R@diego>
Message-ID: <2303499.bZIqGxfG9l@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Freitag, 5. Juni 2015, 17:52:48 schrieb Heiko St?bner:
> could we do this something like the shown below instead?
> Here the deassertion of the reset really happens after we are sure the
> power-domain is on
 
As you mention in the gerrit cl that the hang does happen when you
deassert the reset before the power-domain wait, ignore my last message please 
:-)

But please make sure to also provide a changelog to the list submissions in 
the future.


Thanks
Heiko
