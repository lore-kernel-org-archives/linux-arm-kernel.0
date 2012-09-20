From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 20 Sep 2012 10:17:07 +0200
Subject: [PATCH 00/11] pinctrl: mvebu: pinctrl driver
In-Reply-To: <CACRpkda+Kav6RGstSQ9+BCgVV+pR6ca_HmoueODYubX_xYM8Jw@mail.gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkda+Kav6RGstSQ9+BCgVV+pR6ca_HmoueODYubX_xYM8Jw@mail.gmail.com>
Message-ID: <505AD103.8050004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2012 10:13 AM, Linus Walleij wrote:
> I've tried to group related implementations together, so if the first four
> are dependent we should either:
>
> 1. Move all of these to the subdir drivers/pinctrl/mvebu

Linus,

I prefer having a subdirectory as there are three more SoCs related
to mvebu.

> Either way it's NO BIG DEAL, so I will take care of this after they
> are merged unless you feel like just fixing it in-flight at this moment.

I think integration into Marvell tree is a little bit stalled by other
patches. Hopefully, today I find some time and update the patches accordingly.

Sebastian
