From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Wed, 20 Apr 2016 16:41:46 -0300
Subject: [PATCH v2] ARM: dts: imx6: Add dts for Embest MarS Board
In-Reply-To: <CAOMZO5AKdFtCZJSFg5ZJ2j8MBta_s=HSNBaH5a9zoTdkwQ477Q@mail.gmail.com>
References: <1460420743-30883-1-git-send-email-sergio.prado@e-labworks.com>
 <CAOMZO5AKdFtCZJSFg5ZJ2j8MBta_s=HSNBaH5a9zoTdkwQ477Q@mail.gmail.com>
Message-ID: <5717DB7A.4030406@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 19-04-2016 08:34, Fabio Estevam wrote:
> On Mon, Apr 11, 2016 at 9:25 PM, Sergio Prado
> <sergio.prado@e-labworks.com> wrote:
>
>> +&fec {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_enet>;
>> +       phy-mode = "rgmii";
>> +       phy-reset-gpios = <&gpio3 31 GPIO_ACTIVE_HIGH>;
>
> Are you sure this is really active high?
>

You are right. Although the ethernet interface did work that way, the 
reset pin is active low. I will fix in V3.

Best regards,

Sergio Prado
