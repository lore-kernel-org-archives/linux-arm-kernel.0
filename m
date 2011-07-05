From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jul 2011 15:20:53 +0800
Subject: [PATCH v2] arm: mach-mmp: brownstone.c support multiple sd slots
In-Reply-To: <CAMj5BkiK17RMY-vEENDqQiDOmfG0Esnp7QDooKWVrhkQL4g6Ow@mail.gmail.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
	<20110427093328.GU17290@n2100.arm.linux.org.uk>
	<161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
	<1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com>
	<20110428095127.GX17290@n2100.arm.linux.org.uk>
	<3BFCE791-3BAD-42ED-BC87-A27F40D6C77C@marvell.com>
	<CAMPhdO-TTRP-k7J-zrG2_rQJsmNDRhTgpqiiX2yqW+Egf8+t2A@mail.gmail.com>
	<CAMj5BkiK17RMY-vEENDqQiDOmfG0Esnp7QDooKWVrhkQL4g6Ow@mail.gmail.com>
Message-ID: <CAMPhdO-b_dpC2ueexEFujr6p_NRb2JwDc0-UEx3cfOSVcZ-d6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2011 at 3:05 PM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> On Tue, Jul 5, 2011 at 2:52 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> On Fri, Apr 29, 2011 at 4:45 AM, Philip Rakity <prakity@marvell.com> wrote:
>>>
>>> Support multiple sd/eMMC interfaces. enable mmc1, 2, and 3.
>>> mmc2 is used eMMC and slot is marked PERMANENT and 8 bit device.
>>> mmc1 is used for Wifi and slot is marked PERMANENT
>>>
>>> Note: eMMC (mmc2) is set to initialize first to workaround a problem
>>> where booting in logical order requires mmc create work queue
>>> to be multi-threaded otherwise boot process hangs. ?BUG report
>>> send to linux-mmc and linux-kernel mailing list.
>>>
>>> Wifi (mmc1) requires we enable power on the device by toggling
>>> the gpio lines for power and reset.
>>>
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>
>> Applied. Though the email client was fiddling the spaces/CR-LF a bit.
>>
>>> ---
>>> ?arch/arm/mach-mmp/brownstone.c | ? 52 +++++++++++++++++++++++++++++++++++++++-
>>> ?1 files changed, 51 insertions(+), 1 deletions(-)
>>>
>
> Hi, Eric
>
> arch/arm/mach-mmp/brownstone.c has already been modified from
> mmc-next, here will have conflict.
> Sorry for inconvenience.

'K, I'll drop it then.

>
> Thanks
>
