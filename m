From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Oct 2015 15:49:30 -0600
Subject: [PATCH v3] Tegra: DT: add device tree binding doc for QSPI
In-Reply-To: <731fc53aa2d24edc93c2af43a7711657@HQMAIL104.nvidia.com>
References: <1445891676-3262-1-git-send-email-twarren@nvidia.com>
 <562E954B.5070604@wwwdotorg.org>
 <731fc53aa2d24edc93c2af43a7711657@HQMAIL104.nvidia.com>
Message-ID: <562E9FEA.1080705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2015 03:36 PM, Tom Warren wrote:
> Stephen Warren wrote at Monday, October 26, 2015 2:04 PM:
>> On 10/26/2015 02:34 PM, Tom Warren wrote:
>>> This patch adds the device tree binding doc for the Tegra QSPI
>>> controller on Tegra210.
>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/spi/nvidia,tegra210-qspi.txt
>>> b/Documentation/devicetree/bindings/spi/nvidia,tegra210-qspi.txt
>>
>>> +- clock-names : Must include the following entries:
>>> +  - qspi
>>> +- resets : Must contain an entry for each entry in reset-names.
>>> +  See ../reset/reset.txt for details.
>>> +- reset-names : Must include the following entries:
>>> +  - qspi
>>> +- clocks : Must contain an entry for each entry in clock-names.
>>> +  See ../clocks/clock-bindings.txt for details.
>>
>> Let's keep clocks and clock-names next to each-other in the doc. I don't know
>> why they aren't in the eixsting Tegra SPI doc.
 >
> OK. I assume 'clock-names', then 'clocks' since 'clocks' references clock-names.

That sounds correct.

>> With this issue fixed, this patch looks good to me.
>>
>> Note: I don't see the devicetree mailing list in the CC list. You should probably
>> replace the U-Boot mailing list with it.
 >
> I thought I had it, but may have dropped it. What exactly is the URL of the devicetree mailing list? devicetree-discuss at lists.ozlabs.org? or devicetree at vger.kernel.org?

devicetree at vger.kernel.org

(See the "OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" in 
"MAINTAINERS", or the output of ./scripts/get_maintainers.pl)
