From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Mar 2018 09:51:44 -0300
Subject: [PATCH] clk: imx51: uart4, uart5 gates only exist on imx50, imx53
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01F81FD1B9@nt-mail04>
References: <3BB206AB2B1BD448954845CE6FF69A8E01F81FD1B9@nt-mail04>
Message-ID: <CAOMZO5BxpRX9g=BktT15tCiSFt4CofkRKDHsutVT-8poZ5bHmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,

On Thu, Mar 15, 2018 at 9:43 AM, Patrick Br?nn <P.Bruenn@beckhoff.com> wrote:
> Hi list,
>
> since v4.16-rc1 my board imx53-cx9020 shows multiple WARNINGs like this:

I fixed this problem with this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/clk/imx/clk-imx51-imx53.c?h=next-20180315&id=a275b315334dea3c2151094765387ede421aac92
