From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Jul 2013 12:16:36 -0300
Subject: imx25: How to get frame buffer device in a system using device
 tree
In-Reply-To: <CAO8h3eFq9WhvZYbbeFfWgVEXViR8MAcGaztsvvaLpFSW-W6CfA@mail.gmail.com>
References: <CAO8h3eFq9WhvZYbbeFfWgVEXViR8MAcGaztsvvaLpFSW-W6CfA@mail.gmail.com>
Message-ID: <CAOMZO5Aat-iAN_TJ6BXEopB+WCkKgLjWh67sCXg0jd1DtzmKSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Thu, Jul 4, 2013 at 12:03 PM, Matthias Wei?er <m.weisser.m@gmail.com> wrote:
> Hi
>
> I am currently try to get Linux running on a custom imx25 hardware
> using device tree. So far I am quite successfull and have the system
> up using current mainline kernel and a NFS root file system. Now I
> would like to have the framebuffer driver to get something on the LCD.
>
> My dts file looks like this:

These mx27 examples can help you to implement the support for mx25:

https://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=commitdiff;h=dcd23b848ed2e35f968a10984e255527b4dde3d5;hp=807f38ec8aae50626d5b4705a0a0f5c585275867

https://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=blob;f=arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts;h=390d8f2f84d120bace022322c6319d82cf7e5a47;hb=refs/heads/for-next

Regards,

Fabio Estevam
