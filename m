From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 24 Feb 2012 09:18:56 +0530
Subject: [PATCH v3 1/2] regulator: twl: adapt twl-regulator driver to
 dt
In-Reply-To: <20120223153127.GD4553@opensource.wolfsonmicro.com>
References: <1329996954-27083-1-git-send-email-rnayak@ti.com>
 <1329996954-27083-2-git-send-email-rnayak@ti.com>
 <20120223153127.GD4553@opensource.wolfsonmicro.com>
Message-ID: <4F4708A8.8080608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 February 2012 09:01 PM, Mark Brown wrote:
> On Thu, Feb 23, 2012 at 05:05:53PM +0530, Rajendra Nayak wrote:
>> Modify the twl regulator driver to extract the regulator_init_data from
>> device tree when passed, instead of getting it through platform_data
>> structures (on non-DT builds)
>
> This doesn't apply to current -next, I expect because of the SMPS
> regulator changes which went in.  Please always submit patches against
> -next.  There's also a patch from Tero adding support for some
> additional regulators which is floating around and would conflict with
> this.  Could you guys please coordinate with each other on this?

Sure, I will co-ordinate with Tero and post my patches against -next.
