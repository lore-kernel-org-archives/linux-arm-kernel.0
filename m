From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Dec 2016 13:30:22 +0100
Subject: [PATCH RESEND 2/2] gpio: axp209: add pinctrl support
In-Reply-To: <f46c89f2-478b-93b8-5a66-12d1307d4514@free-electrons.com>
References: <20161123141151.25315-1-quentin.schulz@free-electrons.com>
 <20161123141151.25315-3-quentin.schulz@free-electrons.com>
 <CACRpkdb8cej=AMs2kO1Vks-WYeae+CtAW2YOCc+Pz3E49mcrDQ@mail.gmail.com>
 <f46c89f2-478b-93b8-5a66-12d1307d4514@free-electrons.com>
Message-ID: <CACRpkdbfeZ1PqtKMpP-6ty=43L1C7QQEmeM91pmN-YiOXeysTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 11:13 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:

> So basically:
>
>  - first patch for adding pinctrl to the existing driver
>  - second patch for moving the driver and binding from gpio to pinctrl
> subsystem
>  - third patch for both removing Kconfig entry and Makefile rule from
> gpio subsystem, and adding a Kconfig entry and a Makefile rule in
> pinctrl subsystem
>
> Is that what you want?

No.

Make the patch moving it to pinctrl first. This will be the same as
the patch augmenting Kcongfig and Makefile or it will not compile.

Then a second patch to add the pinctrl features.

Yours,
Linus Walleij
