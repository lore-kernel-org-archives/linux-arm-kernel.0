From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 8 Sep 2015 22:21:03 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx7d: Add USB support
In-Reply-To: <20150908055245.GA7802@shlinux2>
References: <1441677432-3376-1-git-send-email-festevam@gmail.com>
 <20150908055245.GA7802@shlinux2>
Message-ID: <CAOMZO5D__Owa74D=kZiu=J-qhzw870hHvLq3Vhur6BjWzMqrWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Sep 8, 2015 at 2:52 AM, Peter Chen <peter.chen@freescale.com> wrote:

>> +                             phy-clkgate-delay-us = <400>;
>
> You may add above property description at related binding doc

Just sent patches adding 'phy-clkgate-delay-us' property in the usb
code and also into the doc binding.

Regards,

Fabio Estevam
