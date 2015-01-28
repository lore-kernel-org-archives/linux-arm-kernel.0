From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:27:07 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <20150128180322.GA16868@amd>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <CAL_Jsq+rESm8q44ABRbh9hqMsfcMNx0kcXJ5ONbn1=ue-RvHFg@mail.gmail.com>
 <20150128180322.GA16868@amd>
Message-ID: <1511378.TNkQ0peTI1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 January 2015 19:03:22 Pavel Machek wrote:
> > /proc/device-tree. I hope to be retired when that happens...
> 
> Huh. Who thought putting device-tree into /proc was good idea? That
> should have gone to /sys, as it is not process related...
> 

I think /proc/device-tree predates sysfs by about six years. These
days, it is a symlink to /sys/firmware/devicetree/base.

	Arnd
