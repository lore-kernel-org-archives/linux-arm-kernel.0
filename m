From: aisheng.dong@codeaurora.org (aisheng.dong at codeaurora.org)
Date: Thu, 25 Jan 2018 18:10:35 +0800
Subject: [PATCH 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180123103931.GE27764@dragon>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-3-l.stach@pengutronix.de>
 <20180123103931.GE27764@dragon>
Message-ID: <278bb44610b8a27826550732095aba03@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-23 18:39, Shawn Guo wrote:
> On Wed, Jan 17, 2018 at 07:32:43PM +0100, Lucas Stach wrote:
> 
>> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
>> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
>> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
>> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
>> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
>> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
>> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
>> +		>;
>> +		};
> 
> Bad indentation.
> 
> Shawn
> 
>> +
>> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
>> +		fsl,pins = <
>> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
>> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
>> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
>> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
>> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
>> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
>> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
>> +		>;
>> +	};

AFAIK we switched to generic pinconfig since MX7ULP as maintainer won't
access old binding pinctrl drivers.

So i wonder if you may have some special reasons to insist on old 
binding which
i may overlooked?

(I did not receive your pinctrl patch by accidently. So i can't reply on
it before.)

Regards
Dong Aisheng

>> +};
>> --
>> 2.11.0
>> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
