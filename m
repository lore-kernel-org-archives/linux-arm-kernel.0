From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 15 Aug 2016 11:01:22 -0500
Subject: [PATCH 3/3] ARM: dts: imx28: Fix build warnings with W=1
In-Reply-To: <1471203266-30414-3-git-send-email-festevam@gmail.com>
References: <1471203266-30414-1-git-send-email-festevam@gmail.com>
 <1471203266-30414-3-git-send-email-festevam@gmail.com>
Message-ID: <CAL_Jsq+u7c3Tj+AyuXhNhME8uZvJmX2a8EJmHow6Tkd1vv=7nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 14, 2016 at 2:34 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Fix the following build warnings with W=1:
>
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>
> While at it, also pass the 'device_type' property as recommended by the
> ePAPR specification.

I'm surprised it worked without unless you were relying on
skeleton.dtsi. If that's the case, please remove the dependency on
skeleton.dtsi while at it.

Rob
