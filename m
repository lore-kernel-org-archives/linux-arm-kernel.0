From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 19 Feb 2016 11:24:57 -0800
Subject: [1/4] arm64: Broadcom Vulcan support
In-Reply-To: <0c75ddd6-d353-bb73-62e4-bae0ff95a3b0@broadcom.com>
References: <1455389195-31870-2-git-send-email-jchandra@broadcom.com>
 <0c75ddd6-d353-bb73-62e4-bae0ff95a3b0@broadcom.com>
Message-ID: <56C76C09.50800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/02/16 10:15, Ray Jui wrote:
> + bcm-kernel-feedback-list mailing list
> 
> On 2/13/2016 10:46 AM, Jayachandran C. wrote:
>> From: Zi Shen Lim <zlim@broadcom.com>
>>
>> Add a configuration option and a device tree for Broadcom's Vulcan
>> ARM64 processor. brcm-vulcan.dtsi has the on-chip blocks like the
>> PCIe controller, GICv3 with ITS, PMU, system timer and pl011 UART.
>> brcm-vulcan-eval.dts has definitions for a basic evaluation board.
>> The firmware supports PSCI 0.2 for cpu wakeup.
>>
>> Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
>> [ updated and split dts - jchandra at broadcom.com ]
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>>
>> ---
>> arch/arm64/Kconfig.platforms                      |   5 +
>>  arch/arm64/boot/dts/broadcom/Makefile             |   1 +
>>  arch/arm64/boot/dts/broadcom/brcm-vulcan-eval.dts |  33 +++++
>>  arch/arm64/boot/dts/broadcom/brcm-vulcan.dtsi     | 146
>> ++++++++++++++++++++++
>>  4 files changed, 185 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/broadcom/brcm-vulcan-eval.dts
>>  create mode 100644 arch/arm64/boot/dts/broadcom/brcm-vulcan.dtsi
> 
> Could you please name the files "vulcan.dtsi" and "vulcan-eval.dts" so
> it's consistent with the rest of files in the same directory?

I would like to take these patches ASAP so I can include them in our
upcoming 4.6 pull requests, can you do a quick respin adressing Ray's
feedback and adding a MAINTAINERS file?

Thanks!
-- 
Florian
