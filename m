From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarth)
Date: Sat, 07 Jul 2012 23:08:17 +0200
Subject: [PATCH 3/3] ARM: dts: dove: Integrate devicetree support
In-Reply-To: <4FF88F31.7050402@gmail.com>
References: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
 <1341318868-24567-6-git-send-email-sebastian.hesselbarth@googlemail.com>
 <4FF88F31.7050402@gmail.com>
Message-ID: <4FF8A541.6020508@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2012 09:34 PM, Rob Herring wrote:
> On 07/03/2012 07:34 AM, Sebastian Hesselbarth wrote:
>> This integrates devicetree support for Marvell Dove and currently
>> suppported boards.
>>
> You should remove these board config options. A goal with DT is to
> remove board related code.

Hi Rob,

I should have mentioned that this patch series' main goal was not
to present a full blown DT support for mach-dove but to keep up
with ongoing DT support for mach-kirkwood by Andrew Lunn. Both
machs heavily rely on plat-orion and these patches were meant to
help porting to DT.

I can keep the patches for now and resend them later when more
core stuff of plat-orion has been ported to DT.

Sebastian
