From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 9 Dec 2016 21:20:01 -0800
Subject: [PATCH 1/1] arm64: mm: add config options for page table
 configuration
In-Reply-To: <20161209105722.GD11767@arm.com>
References: <1481139600-24455-1-git-send-email-scott.branden@broadcom.com>
 <1481139600-24455-2-git-send-email-scott.branden@broadcom.com>
 <20161208100014.GE33075@MBP.local>
 <762b8bec-60da-0bb8-28f4-b407ad70687b@broadcom.com>
 <20161208185717.GC15141@e104818-lin.cambridge.arm.com>
 <dd102973-5737-3168-bffe-7ac5e769aecb@broadcom.com>
 <20161209105722.GD11767@arm.com>
Message-ID: <9c613ead-d215-3e53-40bf-126be3f1ad3e@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 16-12-09 02:57 AM, Will Deacon wrote:
> On Thu, Dec 08, 2016 at 11:33:39AM -0800, Scott Branden wrote:
>> Since I currently have your attention:  I do think there is fundamental bug
>> in the ARM64 mm implementation.  If you look at /sys/devices/system/memory
>> it only shows the last memoryX section created after init.
>
> That directory doesn't seem to exist on my arm64 systems. Do I have to
> enable something specific in the .config?
I looked in the /sys/devices/system/memory at it doesn't look like it 
appears until memory hotplug is enabled in the system.  This is another 
patch I'm trying to work through at the same time:
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1284943.html

The internals of the memory management subsystem is not something I'm 
too familiar with at this point.
>
> Will
>
Regards,
Scott
