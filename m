From: P.Bruenn@beckhoff.com (=?utf-8?B?UGF0cmljayBCcsO8bm4=?=)
Date: Tue, 5 Dec 2017 14:20:39 +0000
Subject: [PATCH v2 2/5] ARM: dts: imx53: add srtc node
In-Reply-To: <CAOMZO5DiRa1aLFHiFv_-_3J9LLuq-J06FHLQ4o7=r8hrftEpqQ@mail.gmail.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-3-linux-kernel-dev@beckhoff.com>
 <CAOMZO5DiRa1aLFHiFv_-_3J9LLuq-J06FHLQ4o7=r8hrftEpqQ@mail.gmail.com>
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01CB531C1F@NT-Mail07.beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From: Fabio Estevam [mailto:festevam at gmail.com]
>Sent: Dienstag, 5. Dezember 2017 15:14
>On Tue, Dec 5, 2017 at 12:06 PM,  <linux-kernel-dev@beckhoff.com> wrote:
>
>>                         srtc: srtc at 53fa4000 {
>> -                               compatible = "fsl,imx53-rtc", "fsl,imx25-rtc";
>> +                               compatible = "fsl,imx53-rtc";
>>                                 reg = <0x53fa4000 0x4000>;
>>                                 interrupts = <24>;
>> -                               interrupt-parent = <&tzic>;
>>                                 clocks = <&clks IMX5_CLK_SRTC_GATE>;
>> -                               clock-names = "ipg";
>
>srtc node has been removed in linux-next.
>
>You need to re-add it.
Thanks for this super-fast responses!
I will wait a few days for more reviewers and then integrate your comments in a v3. If nothing major show up I will wait until the imx53.dtsi revert landed in Linus tree.

Best regards,
Patrick

Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075
