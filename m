From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 25 Aug 2011 08:53:49 -0300
Subject: MX53Loco reports half of the total memory
In-Reply-To: <20110824214311.GA21759@n2100.arm.linux.org.uk>
References: <CAOMZO5C6gaJUD3RTCwGqDhcojx3Thww22c+tsdC4bvTUmiSw6w@mail.gmail.com>
	<20110824205415.GN31404@pengutronix.de>
	<20110824214311.GA21759@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5A0N6VcTOgWTpqe_mW4ekW1fSY4+=7o8mXSPFeEmjg26w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 6:43 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
...
>> > Shouldn't the kernel report the whole 1GB?
>>
>> Try compiling the kernel with CONFIG_VMSPLIT_2G. On my board this gives:
>
> Or enable highmem.

Enabling CONFIG_HIGHMEM also made the whole 1GB to be reported.
