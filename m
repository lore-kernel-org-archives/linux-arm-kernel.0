From: ayaka@soulik.info (ayaka)
Date: Tue, 20 Sep 2016 03:17:02 +0800
Subject: [RFC PATCH v3 1/2] ARM: dts: samsung: add rga-lvds panel in itop
 elite
In-Reply-To: <CAOMZO5Agngx7b24bo3w7S84xtwZV81c-wAszs0B96FZhMeMW8A@mail.gmail.com>
References: <1474311771-23321-1-git-send-email-ayaka@soulik.info>
 <1474311771-23321-2-git-send-email-ayaka@soulik.info>
 <CAOMZO5Agngx7b24bo3w7S84xtwZV81c-wAszs0B96FZhMeMW8A@mail.gmail.com>
Message-ID: <1c993577-cb51-16a7-2eba-344156959fb8@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/20/2016 03:12 AM, Fabio Estevam wrote:
> On Mon, Sep 19, 2016 at 4:02 PM, Randy Li <ayaka@soulik.info> wrote:
>
>> +       vcc_sys_lcd: sys-lcd {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vcc_5v";
>> +               regulator-min-microvolt = <5000000>;
>> +               regulator-max-microvolt = <5000000>;
>> +               gpio = <&gpl0 4 GPIO_ACTIVE_HIGH>;
> Is this really active high? If so, you should add the
> 'enable-active-high' property.
I see, thank you. Btw, let me make it clearly, it is really an 
independentTransistor, not be controlled by PMIC.
