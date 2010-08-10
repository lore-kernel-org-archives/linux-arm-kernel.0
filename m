From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Aug 2010 23:55:19 +0100
Subject: [PATCH] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <4C61D6E3.1030603@codeaurora.org>
References: <1280890950-19174-1-git-send-email-sboyd@codeaurora.org>
	<4C61D6E3.1030603@codeaurora.org>
Message-ID: <20100810225519.GF7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 03:46:59PM -0700, Stephen Boyd wrote:
> On 08/03/2010 08:02 PM, Stephen Boyd wrote:
>> This is mostly a copy from the s390 implementation (which copied
>> from x86 and sparc), except we print a warning if the Kconfig
>> option is disabled.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>
>
> Ping?
>
> Should I submit this to the patch system?

Unfortunately, there's quite a dearth of information on this patch,
so I can't say.  I think it needs some testing before a decision can
be made.

What compilers have been tested with this?

As the help comments intimate that it needs at least gcc 4.4, and
you've changed it to produce a compile time warning if the option is
disabled, what's the implications for older compilers?
