From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 Jun 2015 18:20:21 -0300
Subject: [PATCH] clocksource: imx: define clocksource for mx27
In-Reply-To: <1435439504-406-1-git-send-email-tremyfr@gmail.com>
References: <1435439504-406-1-git-send-email-tremyfr@gmail.com>
Message-ID: <CAOMZO5CQCAQfAHrUkphsb_38QKk_c7M0S+VigcLp0kzvuakUFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 27, 2015 at 6:11 PM, Philippe Reynes <tremyfr@gmail.com> wrote:
> The clocksource imx27 wasn't defined in timer-imx-gpt.c,
> so the kernel no longer boot on imx27. Just define
> clocksource imx27 as an imx21.
>
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
