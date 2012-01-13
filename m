From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 13 Jan 2012 16:48:16 -0600
Subject: [PATCH 08/11] ep93xx: Move EP93XX_WATCHDOG_BASE define to driver
In-Reply-To: <4F10A63F.1050100@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-9-git-send-email-rmallon@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F001F3F99EBB0B@AUSP01VMBX24.collaborationhost.net>
 <4F10A63F.1050100@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3F99EBCB3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 13, 2012 2:47 PM, Ryan Mallon wrote:
> On 14/01/12 04:45, H Hartley Sweeten wrote:
>> I have a patch to convert the watchdog driver to a platform device and 
>> use the WatchDog Timer Driver Core.  This patch will end up moving the 
>> base define to soc.h instead. But, for now, this looks good.
>
> Is your patch ready to go? I'm in no rush to get these patches in, and I
> can add it to this series if you like, which would get rid of the need for
> this patch and would also mean that we don't need the include of
> <mach/ep93xx-regs.h> in the watchdog driver in the final patch.

Right now I just have the WatchDog Timer Driver Core conversion done.
But, it needs to be retested against the current mainline.

Converting the driver into a platform device is trivial after that.

Let's go with what you have for right now. If/when It hits linux-next I'll
rebase my patch against that.

Regards,
Hartley
