From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 6 Jul 2011 19:56:37 +0800
Subject: [PATCH 2/3] ARM: CSR: mapping early DEBUG_LL uart
In-Reply-To: <CAGsJ_4xRxWXL=xPRgkaLMFxpBtr-bP6xV9iD1UomfzyKmHhSJA@mail.gmail.com>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-3-git-send-email-bs14@csr.com>
	<20110706110522.GQ8286@n2100.arm.linux.org.uk>
	<CAGsJ_4xRxWXL=xPRgkaLMFxpBtr-bP6xV9iD1UomfzyKmHhSJA@mail.gmail.com>
Message-ID: <CAGsJ_4wEtWSHS2uUf124p0KKVVHJ7Zs0epv7QEWn5Xa2uvO9zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/6 Barry Song <21cnbao@gmail.com>:
> hi Russell,
>
> 2011/7/6 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> On Wed, Jul 06, 2011 at 02:47:57AM -0700, Barry Song wrote:
>>> Signed-off-by: Barry Song <bs14@csr.com>
>>
>> Surely this should be part of the first patch, which won't build without
>> this one if DEBUG_LL is enabled?
>
> i guess that can get fixed by:

oh. no, it can't be fixed by any way....

>
> static void __init sirfsoc_map_io(void)
> {
> ? ? ? ?sirfsoc_map_lluart();
> }
>
> MACHINE_START(PRIMA2_EVB, "prima2cb")
> ? ? ?...
> ? ? ? .map_io ? ? ? ? = sirfsoc_map_io,
> ? ? ?...
> MACHINE_END
>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> Thanks
> barry
>
