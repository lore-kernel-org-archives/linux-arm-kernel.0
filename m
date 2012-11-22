From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 22 Nov 2012 22:08:57 +0100
Subject: [PATCH v4 09/11] ARM: dts: AM33XX: Add PWMSS device tree nodes
In-Reply-To: <1353503469-18634-10-git-send-email-avinashphilip@ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-10-git-send-email-avinashphilip@ti.com>
Message-ID: <20121122210857.GH16716@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 06:41:06PM +0530, Philip, Avinash wrote:
> Add PWMSS device tree nodes in relation with ECAP & EHRPWM DT nodes to
> AM33XX SoC family. Also populates device tree nodes for ECAP & EHRPWM by
> adding necessary properties like pwm-cells, base reg & set disabled as
> status.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> ---
> Changes since v2:
> 	- ranges property populated to handle child devices address range
> 
> :100644 100644 20a3f29... 4393161... M	arch/arm/boot/dts/am33xx.dtsi
>  arch/arm/boot/dts/am33xx.dtsi |   84 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 84 insertions(+), 0 deletions(-)

Looks good to me,

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/28e437e8/attachment.sig>
