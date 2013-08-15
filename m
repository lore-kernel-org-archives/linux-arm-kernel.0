From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 15 Aug 2013 07:30:30 -0700
Subject: arm-soc: Xilinx Zynq cleanups for v3.12
In-Reply-To: <20130815031608.4443.32831@quantum> (Mike Turquette's message of
 "Wed, 14 Aug 2013 20:16:08 -0700")
References: <520A47C7.4050000@monstr.eu> <87y585dve9.fsf@kernel.org>
 <20130814050145.4443.97433@quantum> <520B18EF.6030905@monstr.eu>
 <20130815031608.4443.32831@quantum>
Message-ID: <87eh9vni0p.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Turquette <mturquette@linaro.org> writes:

> Quoting Michal Simek (2013-08-13 22:43:11)
>> On 08/14/2013 07:01 AM, Mike Turquette wrote:
>> > Quoting Kevin Hilman (2013-08-13 16:27:10)
>> >> + Mike Turquette
>> >>
>> >> Michal Simek <monstr@monstr.eu> writes:
>> >>
>> >>> Hi Arnd and Olof,
>> >>
>> >> I'm helping out with arm-soc maintenance now too and I'm on the
>> >> arm at kernel.org alias, thanks for Cc'ing it.
>> >>
>> >>> please pull these cleanup patches to your tree.
>> >>>
>> >>> Thanks,
>> >>> Michal
>> >>>
>> >>> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
>> >>>
>> >>>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
>> >>>
>> >>> are available in the git repository at:
>> >>>
>> >>>   git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.12
>> >>>
>> >>> for you to fetch changes up to 060968ff9fa1a56b22cc2454906a233d302b1bd2:
>> >>>
>> >>>   arm: zynq: hotplug: Remove unreachable code (2013-08-13 16:09:12 +0200)
>> >>>
>> >>> ----------------------------------------------------------------
>> >>> arm: Xilinx Zynq cleanup patches for v3.12
>> >>>
>> >>> This branch contains these fixes:
>> >>> - SLCR cleanup
>> >>> - 2 minor zynq pll fixes
>> >>> - Hotplug cleanup
>> >>>
>> >>> ----------------------------------------------------------------
>> >>> Soren Brinkmann (6):
>> >>>       arm: zynq: slcr: Remove redundant header #includes
>> >>>       arm: zynq: slcr: Clean up #defines
>> >>>       arm: zynq: slcr: Use read-modify-write for register writes
>> >>>       clk/zynq/pll: Fix documentation for PLL register function
>> >>>       clk/zynq/pll: Use #defines for fbdiv min/max values
>> >>
>> >> These drivers/clk changes should go through the clock maintainer Mike
>> >> Turquette.  Could you split them out into a separate pull request?
>> >>
>> >> Alternatively, if Mike is confident there won't be any conflicts with
>> >> his tree, I'll happily merge them through arm-soc with his ack.
>> > 
>> > This is my bad. I updated the clk-fixes branch this morning and then got
>> > distracted and never sent the request to Linus.
>> > 
>> > Wait for it ... done.
>> > 
>> > Ok so the two clk patches will hopefully be pulled for -rc6.
>> 
>> These two clk patches in this pull request are different than that 2 patches
>> which should go to this kernel version and which you correctly added
>> to pull request to Linus.
>> 
>> Mike: Are you ok to add these 2 patches to mainline via arm-soc tree?
>> Both changes are cosmetic. If not, I will separate this pull request.
>
> Oops. Well it's good to get the fixes merged anyways. I'm still taking
> patches towards 3.12 so it would be better for me to take them in. Can
> you rebase them on top of clk-next and send me a pull request?

... and then resend $SUBJECT pull request to arm at kernel.org without the
drivers/clk changes.  Thanks.

Kevin
