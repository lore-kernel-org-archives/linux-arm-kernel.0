From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 12 Jan 2010 18:21:50 +0200
Subject: question about ARM11MP cpu architecture identification
Message-ID: <c70ff3ad1001120821u1f546480nd0229e560d84293@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
    The ARM11MP (rev r2p0) cpu architecture is ARMv6, and according to
the http://infocenter.arm.com, its Main ID register is 0x410FB024, and
the MMFR[3:0] is 3. but it looks to me that the cpu_architecture()
will identify it as ARMv7, and if the kernel was configured with
CPU_V7 only, then the lookup_processor_type() function also will
identify it as ARMv7. Am I missing something here?

saeed
