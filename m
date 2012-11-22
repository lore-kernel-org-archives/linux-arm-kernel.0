From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 22 Nov 2012 22:12:45 +0100
Subject: [PATCH v4 11/11] ARM: dts: AM33XX: Add PWM backlight DT data to
 am335x-evmsk
In-Reply-To: <1353503469-18634-12-git-send-email-avinashphilip@ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-12-git-send-email-avinashphilip@ti.com>
Message-ID: <20121122211245.GJ16716@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 06:41:08PM +0530, Philip, Avinash wrote:
> PWM output from ecap2 uses as backlight source. Also adds low threshold
> value to have a uniform divisions in brightness-levels scales with
> inverse polarity.
> 
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> ---
> :100644 100644 f5a6162... 6f3de83... M	arch/arm/boot/dts/am335x-evmsk.dts
>  arch/arm/boot/dts/am335x-evmsk.dts |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)

Same comments as for the previous patch, but otherwise:

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/3fc4c6c8/attachment-0001.sig>
