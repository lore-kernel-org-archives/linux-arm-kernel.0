From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Sep 2017 22:52:26 +0200
Subject: [patch v7 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1504281966-6199-3-git-send-email-oleksandrs@mellanox.com>
References: <1504281966-6199-1-git-send-email-oleksandrs@mellanox.com>
 <1504281966-6199-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <CAK8P3a1Ym1UxbFyeUBrSBeHnoQh9NtBn5r6iVEjU_1ki_p3W5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 1, 2017 at 6:06 PM, Oleksandr Shamray
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

No further comments about this driver, if there is agreement about the subsystem
in general, it looks good to go in.

Acked-by: Arnd Bergmann <arnd@arndb.de

       Arnd
