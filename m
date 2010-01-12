From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 16:34:03 +0000
Subject: question about ARM11MP cpu architecture identification
In-Reply-To: <c70ff3ad1001120821u1f546480nd0229e560d84293@mail.gmail.com>
References: <c70ff3ad1001120821u1f546480nd0229e560d84293@mail.gmail.com>
Message-ID: <20100112163403.GI27771@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 06:21:50PM +0200, saeed bishara wrote:
> Hi,
>     The ARM11MP (rev r2p0) cpu architecture is ARMv6, and according to
> the http://infocenter.arm.com, its Main ID register is 0x410FB024, and
> the MMFR[3:0] is 3. but it looks to me that the cpu_architecture()
> will identify it as ARMv7, and if the kernel was configured with
> CPU_V7 only, then the lookup_processor_type() function also will
> identify it as ARMv7. Am I missing something here?

Welcome to the wonderful world of *unprintable*.  The age of being
able to reliably tell what type of CPU you are running on has sadly
well and truely passed into history.

I'm afraid it's now a hit-and-miss affair.
