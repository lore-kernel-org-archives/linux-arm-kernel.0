From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Jan 2014 10:14:55 -0200
Subject: [PATCH 2/2] ARM: dts: imx6sl-evk: Add audio support
In-Reply-To: <20140128121211.GK20583@S2101-09.ap.freescale.net>
References: <1390443213-14061-1-git-send-email-festevam@gmail.com>
 <1390443213-14061-2-git-send-email-festevam@gmail.com>
 <20140128121211.GK20583@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5BWfrjxJr=f=0hHwQNuJcQDeLSJi=u6Fci44EctKMSCHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 10:12 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

>> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
>> index 95bb37b..04cf457 100644
>> --- a/arch/arm/boot/dts/imx6sl.dtsi
>> +++ b/arch/arm/boot/dts/imx6sl.dtsi
>> @@ -236,6 +236,7 @@
>>                                              <&sdma 38 1 0>;
>>                                       dma-names = "rx", "tx";
>>                                       fsl,fifo-depth = <15>;
>> +                                     fsl,ssi-dma-events = <38 37>;
>
> Do you still need this custom property?

I can get rid of it.

Should I remove from the other SoCs as well?

Regards,

Fabio Estevam
