From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Mar 2017 14:04:25 -0700
Subject: [PATCH] ARM: dts: NSP: GPIO reboot open-source
In-Reply-To: <1488409348-6371-1-git-send-email-jon.mason@broadcom.com>
References: <1488409348-6371-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <20170316210425.3683-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Mar 2017 18:02:28 -0500, Jon Mason <jon.mason@broadcom.com> wrote:
> The libgpio code pre-sets the GPIO values for the gpio-reset in the
> device tree. This results in the device being reset during bringup.
> To prevent this pre-setting, use the "open-source" flag in the device
> tree.
>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Fixes: b1aaf88 ("ARM: dts: NSP: Add GPIO reboot method to bcm958625hr DTS file")
> Fixes: 10baed1 ("ARM: dts: NSP: Add GPIO reboot method to bcm958625xmc DTS file")
> Fixes: 088e3148 ("ARM: dts: NSP: Add new DT file for bcm958522er")
> Fixes: e3227c1 ("ARM: dts: NSP: Add new DT file for bcm958525er")
> Fixes: 2f8bc00 ("ARM: dts: NSP: Add new DT file for bcm958622hr")
> Fixes: d454c37 ("ARM: dts: NSP: Add new DT file for bcm958623hr")
> Fixes: f27eacf ("ARM: dts: NSP: Add new DT file for bcm988312hr")
> ---

Applied, thanks!
--
Florian
