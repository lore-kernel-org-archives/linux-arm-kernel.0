From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Mar 2016 23:18:59 +0800
Subject: [PATCH] ARM: dts: Add dts file for Dserve DSRV9703C tablet
In-Reply-To: <1458374032-10077-1-git-send-email-hdegoede@redhat.com>
References: <1458374032-10077-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v66Hw8_Ckmw0f5GMzP2+73aNbSoOs2MLYu7C85bjUL9huw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 19, 2016 at 3:53 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The Dserve DSRV9703C is a 9.7" A10 tablet with a 1024x768 ips LCD,
> 1G RAM, 4GB flash, a Focaltech FT5406EE8 touchscreen and rtl8188ctv wifi.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  arch/arm/boot/dts/Makefile                       |   1 +
>  arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts | 281 +++++++++++++++++++++++
>  2 files changed, 282 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
>
