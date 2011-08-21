From: robherring2@gmail.com (Rob Herring)
Date: Sun, 21 Aug 2011 13:35:35 -0500
Subject: [PATCH] ARM: mach-footbridge: add missing header file
	<video/vga.h>
In-Reply-To: <CAK5ve-+0-A=Te0Cm5v_xwzhDGJ0NKnTyTL2wDf_HoUrYDcv2Lw@mail.gmail.com>
References: <1313575204-25374-1-git-send-email-bryan.wu@canonical.com>	<CAK5ve-+0rtcC8KiEW9=WHnW8nPTr8+7tmnqUgZJQ_3GV6gMpzw@mail.gmail.com>	<20110821084104.GC12028@n2100.arm.linux.org.uk>
	<CAK5ve-+0-A=Te0Cm5v_xwzhDGJ0NKnTyTL2wDf_HoUrYDcv2Lw@mail.gmail.com>
Message-ID: <4E514FF7.1070506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2011 10:36 AM, Bryan Wu wrote:
> On Sun, Aug 21, 2011 at 4:41 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Aug 19, 2011 at 12:37:09PM +0800, Bryan Wu wrote:
>>> Russell,
>>>
>>> Also this one. any comment?
>>
>> Other than frustration that Rob Herring isn't responding to his breakage
>> (which is making me want to ignore further patches from Rob - clearly
>> doesn't care about the effect of his c9d95fb "ARM: convert PCI defines
>> to variables" patch...)
>>

Sorry, I've been away on vacation Wed-Sat.

> 
> I forgot to add Rob in this email loop. Added now.

Thanks for copying me directly.

> 
>> It looks obviously correct.
>>

I went back to check for other instances and found orion5x is also
broken missing this include. It is also broken by another commit which
I'll fix. Patches coming soon.

Rob
