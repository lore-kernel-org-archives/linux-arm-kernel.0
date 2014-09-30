From: dianders@chromium.org (Doug Anderson)
Date: Tue, 30 Sep 2014 11:24:28 -0700
Subject: [PATCH v7 3/5] ARM: dts: add RK3xxx CPU Thermal data
In-Reply-To: <1411900693-30484-4-git-send-email-caesar.wang@rock-chips.com>
References: <1411900693-30484-1-git-send-email-caesar.wang@rock-chips.com>
 <1411900693-30484-4-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <CAD=FV=WRYeW4giA+yRWmXGxAvdG38GcW-7tA39SZDH1GPamf6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Sun, Sep 28, 2014 at 3:38 AM, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> This patch changes a dtsi file to contain the thermal data
> on RK3288 and later SoCs. This data will
> enable a thermal shutdown over 125C.
>
> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi | 32 +++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi

I haven't done lots of review of this series, but I did notice that
this file has bad spacing.  It's fairly obvious in your gerrit patch
<https://chromium-review.googlesource.com/#/c/220270/1/arch/arm/boot/dts/rk3xxx-cpu-thermal.dtsi>
because gerrit (by default) shows you "tab" characters...

In general you should use tab for indentation, not spaces.  You seem
to use a mix of the two.

-Doug
