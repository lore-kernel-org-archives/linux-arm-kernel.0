From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Aug 2015 10:40:55 +0200
Subject: [PATCH] ARM: at91: at91_dt_defconfig: enable ISI and ov2640
 support
In-Reply-To: <1438276699-11861-1-git-send-email-nicolas.ferre@atmel.com>
References: <1438276699-11861-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150805084055.GD6390@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 07:18:19PM +0200, Nicolas Ferre wrote:
> From: Josh Wu <josh.wu@atmel.com>
> 
> Add Atmel-isi and ov2640 driver in defconfig
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> [nicolas.ferre at atmel.com: make SOC_CAMERA_OV2640 selected as a module]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Arnd, Olof, Kevin,
> 
> This is the only "defconfig" patch that I have for now. Can you please take it
> for 4.3?

applied, thanks.


-Olof
