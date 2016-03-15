From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 15 Mar 2016 11:39:50 +0900
Subject: [PATCH v2 0/7] ARM: dts: Add new Exynos3250-based ARTIK5 module
 dtsi file
In-Reply-To: <56E774DE.4030200@samsung.com>
References: <1458007695-3627-1-git-send-email-cw00.choi@samsung.com>
 <56E774DE.4030200@samsung.com>
Message-ID: <56E775F6.5060004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 03? 15? 11:35, Krzysztof Kozlowski wrote:
> On 15.03.2016 11:08, Chanwoo Choi wrote:
>> This patchset add the support for Device Tree source for Samsung ARTIK5 module[1]
>> based on Exynos3250 SoC and development board[2]. The ARTIK5 module includes
>> the follwoing devices:
>> - Application Processor (Samsung Exynos3250)
>> - WiFi/BT Combo chip
>> - PMIC (Samsung S2MPS14)
>> - eMMC (4GB)
>> - DRAM LPDDR3 (512MB)
>> - Connectors pin (60 Pins x 3 set)
>>
>> Also, this patchset add the ARTIK5 development board[2] dts file which includes
>> the ARTIK5 module[1] and have the devices such as sound codec, sd card port,
>> ethernet port, uart port and so on.
>>
>> [1] https://www.artik.io/hardware/artik-5
>> [2] http://www.digikey.com/product-detail/en/SIP-KITNXB001/1510-1316-ND/5825102
> 
> I guess the rest of patches depend on new clocks, right?

Yes. The new clocks(uart2, mmc2) are used for artik5 module.
- uart2 is used for serial log for debug
- mmc2 is for external sd card

Best Regards,
Chanwoo Choi
