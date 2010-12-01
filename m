From: srinidhikasagar@gmail.com (Srinidhi Kasagar)
Date: Wed, 1 Dec 2010 11:51:42 +0530
Subject: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU bootup
In-Reply-To: <20101130233204.GB14383@n2100.arm.linux.org.uk>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
	<20101130171658.GA24034@oksana.dev.rtsoft.ru>
	<20101130233204.GB14383@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=WHBqq5U8OzkMaprk=vzphZBV0HhLEDF-uAZxW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 1, 2010 at 5:02 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 30, 2010 at 08:16:58PM +0300, Anton Vorontsov wrote:

[...]

>> + ? ? sub ? ? r4, r4, r5
>> + ? ? add ? ? r6, r6, r4
>> +#if __LINUX_ARM_ARCH__ >= 7
>> + ? ? dsb
>> +#endif
>
> Another question though - probably for Linus though - why is the u8500
> code needing this dsb whereas other ARMv7 implementations don't appear
> to require it?

No strong reason, we can safely ignore this now.

srinidhi
