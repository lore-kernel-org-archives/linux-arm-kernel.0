From: joel@jms.id.au (Joel Stanley)
Date: Thu, 11 Jan 2018 09:45:35 -0800
Subject: [patch v15 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1514202808-29747-3-git-send-email-oleksandrs@mellanox.com>
References: <1514202808-29747-1-git-send-email-oleksandrs@mellanox.com>
 <1514202808-29747-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <CACPK8XfFxWy+XvWJNSV3Ouy2WyGe1Hc2QP0bddPenqH_6673hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 25, 2017 at 3:53 AM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:
> Driver adds support of Aspeed 2500/2400 series SOC JTAG master controller.
>
> Driver implements the following jtag ops:
> - freq_get;
> - freq_set;
> - status_get;
> - idle;
> - xfer;
>
> It has been tested on Mellanox system with BMC equipped with
> Aspeed 2520 SoC for programming CPLD devices.
>
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
