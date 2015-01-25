From: djkurtz@chromium.org (Daniel Kurtz)
Date: Sun, 25 Jan 2015 10:13:22 +0800
Subject: [PATCH 0/2] ARM: dts: rockchip: add basic display nodes
In-Reply-To: <3715086.HVfme6flvD@phil>
References: <3715086.HVfme6flvD@phil>
Message-ID: <CAGS+omAWJWOGpdFdqV57NkzVZGdnXmuZua3RG5XBZKzX8OBW9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 5:31 AM, Heiko St?bner <heiko@sntech.de> wrote:
> The core drm support will be part of 3.19 and the hdmi support will enter
> the 3.20 kernel - so add at least the basic devicetree nodes.
>
> I've pulled these patches out of the Chromium tree, adapted them to the
> current mainline dts and have been using them with a bunch of code on top
> with the vga connector of a firefly board for a week or so.
>
> @Daniel et all: I hope I've kept all the tags and attributions intact.
> If anything is wrong please holler.

The series looks good to me.
Thanks!

>
>
> Andy Yan (1):
>   ARM: dts: rockchip: add rk3288 hdmi nodes
>
> Daniel Kurtz (1):
>   ARM: dts: rockchip: Add rk3288 vop and display-subsystem
>
>  arch/arm/boot/dts/rk3288.dtsi | 76 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> --
> 2.1.1
>
>
