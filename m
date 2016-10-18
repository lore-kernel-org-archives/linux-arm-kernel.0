From: jagan@openedev.com (Jagan Teki)
Date: Tue, 18 Oct 2016 17:30:28 +0530
Subject: [PATCH v7 0/5] ARM: dts: imx6q: Add Engicam i.CoreM6 dts
In-Reply-To: <1476437243-13297-1-git-send-email-jteki@openedev.com>
References: <1476437243-13297-1-git-send-email-jteki@openedev.com>
Message-ID: <CAD6G_RQyLtgJw=djPTmY5t7UVwzuZpj0xM0HjchLQjq7P5hMOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Oct 14, 2016 at 2:57 PM, Jagan Teki <jteki@openedev.com> wrote:
> This is series add dts support for Engicam I.Core M6 qdl modules. just
> rebased on top of linux-next of previous set[1].
>
> [1] http://www.spinics.net/lists/kernel/msg2358233.html
>
> Jagan Teki (5):
>   ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual initial support
>   ARM: dts: imx6q: Add Engicam i.CoreM6 DualLite/Solo initial support
>   ARM: dts: imx6qdl-icore: Add usbhost support
>   ARM: dts: imx6qdl-icore: Add usbotg support
>   ARM: dts: imx6qdl-icore: Add FEC support
>
>  arch/arm/boot/dts/Makefile           |   2 +
>  arch/arm/boot/dts/imx6dl-icore.dts   |  59 ++++++++
>  arch/arm/boot/dts/imx6q-icore.dts    |  59 ++++++++
>  arch/arm/boot/dts/imx6qdl-icore.dtsi | 271 +++++++++++++++++++++++++++++++++++
>  4 files changed, 391 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-icore.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-icore.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-icore.dtsi

Can you pick this series?

thanks!
-- 
Jagan Teki
Free Software Engineer | www.openedev.com
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
