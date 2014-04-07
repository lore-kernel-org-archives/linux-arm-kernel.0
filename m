From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 07 Apr 2014 13:11:41 +0100
Subject: drivers/clk/bcm/clk-bcm281xx.c breaks on GCC 4.6.4 (and earlier)
In-Reply-To: <534292F2.1040803@linaro.org> (Alex Elder's message of "Mon, 07
 Apr 2014 06:58:42 -0500")
References: <20140407092609.GY7528@n2100.arm.linux.org.uk>
 <534292F2.1040803@linaro.org>
Message-ID: <yw1xob0dgwzm.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex Elder <elder@linaro.org> writes:

> On 04/07/2014 04:26 AM, Russell King - ARM Linux wrote:
>> So this greeted me this morning...
>
> That sucks.
>
> I don't see that, and I'm running 4.6.3.  (And I'm obviously
> not testing with different versions of the compiler.)
>
> I'll be investigating.

Could it have something to do with the unnamed struct member in struct
bcm_clk_div which appears to be the fields these errors refer to?

It would of course help if Russel specified what tree he was building.

-- 
M?ns Rullg?rd
mans at mansr.com
