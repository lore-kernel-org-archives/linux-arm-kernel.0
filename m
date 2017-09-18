From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 18 Sep 2017 21:28:42 +0530
Subject: [PATCH v4 0/2] i2c: davinci: Add PM Runtime Support needed by
 66AK2G
In-Reply-To: <20170911201145.31257-1-fcooper@ti.com>
References: <20170911201145.31257-1-fcooper@ti.com>
Message-ID: <7b1c9624-01de-84a5-7236-3a0dbe8f9e5f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 September 2017 01:41 AM, Franklin S Cooper Jr wrote:
> Add I2C support to 66AK2G. Primary requirement is to add PM
> Runtime support to the driver.
> 
> This has been tested on following platforms by performing simple i2c test
> such as i2c detect and reading on board i2c devices:
> K2G GP evm
> OMAPL138
> K2L GP EVM
> 
> and boot tested on:
> K2E GP EVM
> K2HK GP EVM
> 
> Version 2 changes:
> Moved ordering of pm runtime calls
> 
> Version 3 changes:
> Dropped first patch since it was pulled in.
> Remove clk = NULL statements
> Fix error path
> 
> Version 4 changes:
> Fix typo in commit message
> Fix error path

Acked-by: Sekhar Nori <nsekhar@ti.com>

Tested on DA850 LCDK board with some basic i2cdetect/i2cdump and
suspend/resume tests.

Thanks,
Sekhar
