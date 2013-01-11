From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 11 Jan 2013 10:31:56 +0530
Subject: [PATCH 1/7] clk: add common of_clk_init() function
In-Reply-To: <20130110195347.GN19380@beefymiracle.amer.corp.natinst.com>
References: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
 <20130110195347.GN19380@beefymiracle.amer.corp.natinst.com>
Message-ID: <50EF9CC4.8030600@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 January 2013 01:23 AM, Josh Cartwright wrote:
> * PGP Signed by an unknown key
>
> On Fri, Jan 04, 2013 at 12:30:52PM +0530, Prashant Gaikwad wrote:
>> Modify of_clk_init function so that it will determine which
>> driver to initialize based on device tree instead of each driver
>> registering to it.
>>
>> Based on a similar patch for drivers/irqchip by Thomas Petazzoni and
>> drivers/clocksource by Stephen Warren.
>>
>> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
>> ---
> Prashant-
>
> Sorry for the late response, but I finally got a chance to give this
> patchset a spin on Zynq.  For patches 1 and 6:
>
> Reviewed-by: Josh Cartwright <josh.cartwright@ni.com>
> Tested-by: Josh Cartwright <josh.cartwright@ni.com>
>
>    Josh

Thanks Josh!!

> * Unknown Key
> * 0x846F0FA5
