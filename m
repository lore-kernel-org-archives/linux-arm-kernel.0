From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Mar 2014 23:20:32 -0300
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Add USB Host1 support
In-Reply-To: <07405bf6fc4841d5b0d22c07c582acb9@BL2PR03MB226.namprd03.prod.outlook.com>
References: <1395750922-3244-1-git-send-email-festevam@gmail.com>
 <07405bf6fc4841d5b0d22c07c582acb9@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <CAOMZO5Da9poOv8KqCsSxnjs4eZkVbRPCmnJCj-OX3ps8=+y+Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Mar 25, 2014 at 11:00 PM, Peter Chen <Peter.Chen@freescale.com> wrote:

>> +
>> +             usbphy1: usbphy at 1 {
>> +                     compatible = "usb-nop-xceiv";
>> +                     reg = <1>;
>> +                     clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
>> +                     clock-names = "main_clk";
>> +             };
>>       };
>>
>
> You are using usb nop phy driver (phy-generic.c) for ulpi phy,
> Are you sure your phy doesn't need any configurations from viewport?

I am not sure I understood your comment.

This node is the same like we do on mx53 and other i.mx SoCs.

Both USB host and OTG are functional.

Could you please explain your concern?

Regards,

Fabio Estevam
