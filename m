From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2012 10:13:15 +0200
Subject: [PATCH 00/11] pinctrl: mvebu: pinctrl driver
In-Reply-To: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkda+Kav6RGstSQ9+BCgVV+pR6ca_HmoueODYubX_xYM8Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a minor thing here:

On Sat, Aug 11, 2012 at 2:56 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

>  drivers/pinctrl/pinctrl-armada-370.c               |  421 +++++++++++
>  drivers/pinctrl/pinctrl-armada-xp.c                |  466 ++++++++++++
>  drivers/pinctrl/pinctrl-dove.c                     |  622 ++++++++++++++++
>  drivers/pinctrl/pinctrl-kirkwood.c                 |  460 ++++++++++++
>  drivers/pinctrl/pinctrl-mvebu.c                    |  758 ++++++++++++++++++++
>  drivers/pinctrl/pinctrl-mvebu.h                    |  175 +++++

I've tried to group related implementations together, so if the first four
are dependent we should either:

1. Move all of these to the subdir drivers/pinctrl/mvebu
2. Rename then drivers/pinctrl/pinctrl-mvebu-dove.c (etc)

Either way it's NO BIG DEAL, so I will take care of this after they
are merged unless you feel like just fixing it in-flight at this moment.

Yours,
Linus Walleij
