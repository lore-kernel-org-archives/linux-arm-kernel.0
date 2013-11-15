From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 15 Nov 2013 10:07:36 -0700
Subject: [PATCH 3/8] ARM: dts: imx: imx6sl/qdl-pingrp: reorganize USDHCx
 pad groups
In-Reply-To: <20131115120417.GJ16735@n2100.arm.linux.org.uk>
References: <1384462934-17390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1384462934-17390-4-git-send-email-troy.kisky@boundarydevices.com>
 <20131115120417.GJ16735@n2100.arm.linux.org.uk>
Message-ID: <528654D8.6020104@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2013 5:04 AM, Russell King - ARM Linux wrote:
> On Thu, Nov 14, 2013 at 02:02:09PM -0700, Troy Kisky wrote:
>> +#define MX6QDL_USDHC1_D4(pad, pad_clk) \
>> +	MX6QDL_PAD_SD1_CMD__SD1_CMD			pad \
>> +	MX6QDL_PAD_SD1_CLK__SD1_CLK			pad_clk \
>> +	MX6QDL_PAD_SD1_DAT0__SD1_DATA0			pad \
>> +	MX6QDL_PAD_SD1_DAT1__SD1_DATA1			pad \
>> +	MX6QDL_PAD_SD1_DAT2__SD1_DATA2			pad \
>> +	MX6QDL_PAD_SD1_DAT3__SD1_DATA3			pad
> DATA3 should be specified separately as you may want that to have a
> different pull direction due to the workarounds in the driver interfering
> with the card present detection.
>
Good point. I will respin.

Thanks
Troy
