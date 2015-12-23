From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Wed, 23 Dec 2015 12:09:59 +0200
Subject: [PATCH v2 0/2] i2c:dw: Add APM X-Gene ACPI I2C device support
In-Reply-To: <BLUPR12MB0451770284D7788418640F699DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
References: <1449782357-22982-1-git-send-email-lho@apm.com>
 <566F6485.2000508@amd.com>
 <20151215132721.GJ1762@lahna.fi.intel.com>
 <56702923.9010305@amd.com>
 <20151215145953.GK1762@lahna.fi.intel.com>
 <1450863241.7740.30.camel@kxue-X58A-UD3R>
 <20151223095237.GJ1758@lahna.fi.intel.com>
 <BLUPR12MB0451770284D7788418640F699DE60@BLUPR12MB0451.namprd12.prod.outlook.com>
Message-ID: <20151223100959.GK1758@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 10:02:04AM +0000, Zheng, Ivan wrote:
> Why/how can Linux driver make use of such non-ACPI defined methods?

What do you mean exactly?

I added support for these (well, SSCN and FMCN) because I found out that
some vendors include such methods with their BIOS implementation.
Windows driver uses these if present and so do we.
