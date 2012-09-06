From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 6 Sep 2012 12:38:47 -0300
Subject: DTS support for the Iomega ix2-200
In-Reply-To: <CADhrpJ4p4U2f6uj+uDQg0f0yGaOodAyBTLhBJQeWKCn-vSkY3w@mail.gmail.com>
References: <CADhrpJ4p4U2f6uj+uDQg0f0yGaOodAyBTLhBJQeWKCn-vSkY3w@mail.gmail.com>
Message-ID: <CAOMZO5Bp4NcaZZ8bsny5CM-o8JQnyWQkkEEimY18vjUhZMmBpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 9:46 AM, alan butler <alanbutty12@gmail.com> wrote:

> I have created a dts file and a board config and made the appropriate
> changes to build
> the support into the kernel but when i try to boot the kernel it just stops
> at the following
> line:
>
> turn off boot console earlycon0

Not sure if is is the same issue, but I got the same message sometime
ago when booting mx31 and the reason was a missing
pinctrl_provide_dummies():
http://www.spinics.net/lists/arm-kernel/msg176093.html

Regards,

Fabio Estevam
