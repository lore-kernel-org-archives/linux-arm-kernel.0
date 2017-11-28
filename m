From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 28 Nov 2017 12:16:47 +0100
Subject: [PATCH v3 4/6] ARM: dts: imx6qdl: Add Variscite DART-MX6 SoM
 support
In-Reply-To: <CAOMZO5DXh1K4fnw0mCEwpXc0WFMUW1sCsjv==TUHM5vr3DqFaQ@mail.gmail.com>
References: <1511785716-23492-1-git-send-email-narmstrong@baylibre.com>
 <1511785716-23492-5-git-send-email-narmstrong@baylibre.com>
 <CAOMZO5DXh1K4fnw0mCEwpXc0WFMUW1sCsjv==TUHM5vr3DqFaQ@mail.gmail.com>
Message-ID: <f4528216-b0b1-4492-8069-b3ed384fb063@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/2017 13:57, Fabio Estevam wrote:
> On Mon, Nov 27, 2017 at 10:28 AM, Neil Armstrong
> <narmstrong@baylibre.com> wrote:
> 
>> +&pcie {
>> +       fsl,tx-swing-full = <103>;
>> +       fsl,tx-swing-low = <103>;
>> +       reset-gpio = <&gpio4 11 GPIO_ACTIVE_HIGH>;
> 
> This can only be active high if 'reset-gpio-active-high' property is
> present, so what you
> want here is:
>   reset-gpio = <&gpio4 11 GPIO_ACTIVE_LOW>;
> 
> With this fixed:
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> 

Ok,

I will post a v4 lately with this fixed.

Thanks,
Neil
