From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2012 23:35:02 -0700
Subject: [PATCH 2/4] ARM: dt: tegra20.dtsi: Add Memory Controller(MC) nodes
In-Reply-To: <1336635764-30597-2-git-send-email-hdoyu@nvidia.com>
References: <1336635764-30597-1-git-send-email-hdoyu@nvidia.com>
 <1336635764-30597-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <CAOesGMiPvw72006zpSGLBNi-C12MTc_w2QmOPg6YTfXMW+ZSkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Tiny drive-by nit pick.

On Thu, May 10, 2012 at 12:42 AM, Hiroshi DOYU <hdoyu@nvidia.com> wrote:
> Add Tegra MC(Memory Controller) nodes for tegra20.dtsi.
>
> Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> ---
> ?arch/arm/boot/dts/tegra20.dtsi | ? ?7 +++++++
> ?1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 24129fb..548b42e 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -211,5 +211,12 @@
> ? ? ? ? ? ? ? ?compatible = "nvidia,tegra20-ahb";
> ? ? ? ? ? ? ? ?reg = <0x6000c004 0x10c>; /* AHB Arbitration + Gizmo Controller */
> ? ? ? ?};
> +
> + ? ? ? mc {

It's common to use a more plain english name here, so
"memory-controller" would be a good name.



-Olof
