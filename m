From: mylene.josserand@free-electrons.com (Mylene Josserand)
Date: Wed, 18 Jan 2017 08:58:29 +0100
Subject: [PATCH v2 02/10] clk: ccu-sun8i-a33: Add CLK_SET_RATE_PARENT to
 ac-dig
In-Reply-To: <20170117164415.4qseqbqkdx3e6bvt@lukather>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-3-mylene.josserand@free-electrons.com>
 <20170117164415.4qseqbqkdx3e6bvt@lukather>
Message-ID: <7a631ab7-8152-25e0-ba3b-845f207388f5@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17/01/2017 17:44, Maxime Ripard wrote:
> Hi,
>
> On Tue, Jan 17, 2017 at 03:02:22PM +0100, Myl?ne Josserand wrote:
>> The audio DAI needs to set the clock rates of the ac-dig clock.
>> To make it possible, the parent PLL audio clock rates should
>> also be changed. This is possible via "CLK_SET_RATE_PARENT" flag.
>>
>> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
>
> Please make sure to look at the prefixes usually used in the commit
> titles of the area you're working on. In this case that would have
> been "clk: sunxi-ng:". I fixed it, and applied.

Okay, I will pay more attention to prefixes for commit titles for next 
times.

Thank you !

-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
