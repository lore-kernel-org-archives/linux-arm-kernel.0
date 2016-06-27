From: carlo@caione.org (Carlo Caione)
Date: Mon, 27 Jun 2016 10:45:51 +0200
Subject: [PATCH v3 1/5] ARM: dts: meson: minix-neo-x8: define PMIC as
 power controller
In-Reply-To: <20160626011515.4428-2-stefan@agner.ch>
References: <20160626011515.4428-1-stefan@agner.ch>
 <20160626011515.4428-2-stefan@agner.ch>
Message-ID: <20160627084551.GB1737@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/06/16 18:15, Stefan Agner wrote:
> The PMIC driver used to register itself as poweroff controller by
> default, hence assuming that this device is using the PMIC as
> system power controller.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Acked-by: Carlo Caione <carlo@endlessm.com>

-- 
Carlo Caione
