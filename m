From: paul.liu@linaro.org (Ying-Chun Liu (PaulLiu))
Date: Fri, 30 Mar 2012 16:09:17 +0800
Subject: [PATCH] ARM: dts: imx6q: add anatop regulators
In-Reply-To: <20120322074520.GD2213@S2101-09.ap.freescale.net>
References: <1332214139-6833-1-git-send-email-paul.liu@linaro.org>
 <20120322074520.GD2213@S2101-09.ap.freescale.net>
Message-ID: <4F756A2D.9020500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2012?03?22? 15:45), Shawn Guo wrote:
>> +				};
>> +
>> +				regulator-1p1 at 110 {
>> +					compatible = "fsl,anatop-regulator";
>> +					regulator-name = "vdd1p1";
>> +					regulator-min-microvolt = <800000>;
>> +					regulator-max-microvolt = <1400000>;
>> +					regulator-always-on;
>> +					reg = <0x110>;
>> +					anatop-vol-bit-shift = <8>;
>> +					anatop-vol-bit-width = <5>;
>> +					anatop-min-bit-val = <4>;
>> +					anatop-min-voltage = <800000>;
>> +					anatop-max-voltage = <1400000>;
> 
> 1.375V

Hi Shawn,

Sorry, why it is not 1.4V?

LDO 1p1 should be from range 0.8V to 1.4V on section 53.3.1
