From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 28 Mar 2014 14:32:36 +0100
Subject: *READ THIS IF YOUR SOC HAS A L2 CACHE* PL310 auxctrl settings
In-Reply-To: <20140328130236.GG7528@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140316152953.GX21483@n2100.arm.linux.org.uk>
 <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
 <20140318112221.GV21483@n2100.arm.linux.org.uk> <5335704F.4090502@st.com>
 <20140328130236.GG7528@n2100.arm.linux.org.uk>
Message-ID: <533579F4.2010201@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/28/2014 02:02 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 28, 2014 at 01:51:27PM +0100, Maxime Coquelin wrote:
>> On 03/18/2014 12:22 PM, Russell King - ARM Linux wrote:
>>> arch/arm/mach-sti/board-dt.c:                           Y  30480000 c0000fff
>>
>> For STiH416 SoC, the reset value of the AUX_CTRL register is 0x02000000.
>> So bits 19:17 = 0, whereas the expected value is bits 19:17 = 4.
>
> Which L2 cache is it?  210/220/310 ?
It is the 310.

Regards,
Maxime

>
> Thanks.
>
