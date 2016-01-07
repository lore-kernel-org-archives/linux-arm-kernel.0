From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 7 Jan 2016 11:10:27 +0530
Subject: Nokia N900: u-SD card in v4.2+
In-Reply-To: <20160106204627.GA21477@amd>
References: <20160106204627.GA21477@amd>
Message-ID: <568DFA4B.7030308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 07 January 2016 02:16 AM, Pavel Machek wrote:
> Hi!
> 
> In v4.1, both internal MMC and u-SD cards work ok.
> 
> In v4.2, only the internal MMC is detected. In v4.3, not even internal
> MMC works. In v4.4, only the internal MMC is detected.
> 
> Does it work for you? Any patches?

I don't have Nokia N900 to check this, but can you share your config and kernel
logs? Check if CONFIG_REGULATOR_PBIAS is present in your config.
CONFIG_REGULATOR_PBIAS is now mandatory for all omap3+ SoCs to work.

Thanks
Kishon

> 
> (I do have hack in the dts to disable back cover detection...)
> 
> 									Pavel
> 
