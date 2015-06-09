From: Haikun.Wang@freescale.com (Wang Haikun)
Date: Tue, 9 Jun 2015 11:56:37 +0000
Subject: [PATCH v1] arm: configs: Add Freescale LS1021A defconfig
References: <1431951726-10992-1-git-send-email-haikun.wang@freescale.com>
 <6265444.OllNdeKdQh@wuerfel>
Message-ID: <DM2PR0301MB0623772476D9BF44B1D7AE42F8BE0@DM2PR0301MB0623.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/20/2015 11:36 PM, Arnd Bergmann wrote:
> On Monday 18 May 2015 20:22:06 Haikun Wang wrote:
>> Add Freescale LS1021A initial defconfig file.
>> Enable I2C, LPUART, eDMA, WDT default.
>> LS1021AQDS and LS1021ATWR boot successfully with patch.
>> Above IPs also been verified successfully.
>>
>> Signed-off-by: Haikun Wang <haikun.wang@freescale.com>
>>
>
> Can you explain why you need a separate defconfig, aside from imx_v6_v7_defconfig
LS1021A is different from I.MX. Also it has some special configure 
options. So it needs a separate defconfig.
> and multi_v7_defconfig? Please put a reason into the description above,
> as we normally try to have only one defconfig per machine directory.
>
> Does this machine require LPAE to function correctly?
Yes, we need it to access 40-bit address space, such as PCIE.

Best regards,
Wang Haikun
>
> 	Arnd
>
