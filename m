From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Jan 2011 12:39:31 -0200
Subject: [PATCH 2/2] ARM i.MX53 enable LOCO board bootup
In-Reply-To: <1294726998-20830-3-git-send-email-yong.shen@freescale.com>
References: <1294726998-20830-1-git-send-email-yong.shen@freescale.com>
	<1294726998-20830-3-git-send-email-yong.shen@freescale.com>
Message-ID: <AANLkTimW54m2f+Z21F+9dLw78WOS24W4yc00D5rztM0C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Tue, Jan 11, 2011 at 4:23 AM,  <yong.shen@freescale.com> wrote:
> From: Yong Shen <yong.shen@freescale.com>
>
> 1. Add Kconfig and Makefile entries
> 2. Add board definition
> 3. enable uart and fec for LOCO board
>
> Signed-off-by: Yong Shen <yong.shen@freescale.com>
> ---
....

> + ? ? ? }
> + ? ? ? gpio_direction_output(LOCO_FEC_PHY_RST, 0);
> + ? ? ? gpio_set_value(LOCO_FEC_PHY_RST, 0);

As Baruch pointed out on a previous post, you can remove the
gpio_set_value line here.

Regards,

Fabio Estevam
