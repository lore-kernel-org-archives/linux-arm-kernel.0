From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 22 Jun 2015 16:36 +0200
Subject: [PATCH] ARM: dts: rockchip: Add ramp delay for vdd_cpu in firefly
 board dts
In-Reply-To: <1434390101-27000-1-git-send-email-romain.perier@gmail.com>
References: <1434390101-27000-1-git-send-email-romain.perier@gmail.com>
Message-ID: <239166562.834dQUR87q@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 15. Juni 2015, 17:41:41 schrieb Romain Perier:
> Adds ramp delay for the vdd_cpu output. It removes warning "ramp_delay not
> set" emitted by the function regulator_set_voltage_time_sel() by the same
> time, which floods kernel logs.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---

applied to dts changes for 4.3
