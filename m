From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 24 Nov 2016 00:13:20 +0100
Subject: [PATCH 6/9] power_supply: wm97xx_battery: use
 power_supply_get_drvdata
In-Reply-To: <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161123231320.fo3kilw5h7cctngc@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Wed, Oct 26, 2016 at 09:41:44PM +0200, Robert Jarzmik wrote:
> As the power supply framework provides a way to store and retrieve
> private supply data, use it.
> 
> In the process, change the platform data for wm97xx_battery from a
> container of a single struct wm97xx_batt_pdata to the direct point to wm97xx_batt_pdata.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/input/touchscreen/wm97xx-core.c |  2 +-
>  drivers/power/supply/wm97xx_battery.c   | 25 ++++++++++---------------
>  2 files changed, 11 insertions(+), 16 deletions(-)

I queued this into power-supply's for-next branch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/37574d6b/attachment.sig>
