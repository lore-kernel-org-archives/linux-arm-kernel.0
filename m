From: jagan@openedev.com (Jagan Teki)
Date: Thu, 27 Oct 2016 14:17:19 +0530
Subject: [PATCH v8 0/3] ARM: dts: imx6q: Add Engicam i.CoreM6 dts
In-Reply-To: <1477037153-20484-1-git-send-email-jteki@openedev.com>
References: <1477037153-20484-1-git-send-email-jteki@openedev.com>
Message-ID: <CAD6G_RRHcyyJ-ibB1yazrOaDGndPLmJWXqXgC=r=2W7Ya0fmrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Oct 21, 2016 at 1:35 PM, Jagan Teki <jteki@openedev.com> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> This is series add dts support for Engicam I.Core M6 qdl modules. just
> rebased on top of linux-next.
>
> Jagan Teki (3):
>   ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual initial support
>   ARM: dts: imx6q: Add Engicam i.CoreM6 DualLite/Solo initial support
>   ARM: dts: imx6qdl-icore: Add FEC support
>
>  arch/arm/boot/dts/Makefile           |   2 +
>  arch/arm/boot/dts/imx6dl-icore.dts   |  59 ++++++++
>  arch/arm/boot/dts/imx6q-icore.dts    |  59 ++++++++
>  arch/arm/boot/dts/imx6qdl-icore.dtsi | 265 +++++++++++++++++++++++++++++++++++
>  4 files changed, 385 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-icore.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-icore.dts
>  create mode 100644 arch/arm/boot/dts/imx6qdl-icore.dtsi

Please let me know if you have any inputs on this?

thanks!
-- 
Jagan Teki
Free Software Engineer | www.openedev.com
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
