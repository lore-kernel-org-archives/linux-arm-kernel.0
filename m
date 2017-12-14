From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 14 Dec 2017 19:14:47 +0100
Subject: [patch v14 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1513268971-13518-3-git-send-email-oleksandrs@mellanox.com>
References: <1513268971-13518-1-git-send-email-oleksandrs@mellanox.com>
 <1513268971-13518-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <CAOFm3uHohuaoBYWCxnwzDgGATrt8Zf1B-JaOtQ0sZgf+=sSovw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oleksandr,

On Thu, Dec 14, 2017 at 5:29 PM, Oleksandr Shamray
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
> ---
> v13->v14
> Comments pointed by Philippe Ombredanne <pombredanne@nexb.com>
> - Change style of head block comment from /**/ to //
>
> v12->v13
> Comments pointed by Philippe Ombredanne <pombredanne@nexb.com>
> - Change jtag-aspeed.c licence type to
>   SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>   and reorder line with license in description

Thanks for the SPDX tags! for this part you have my ack:

Acked-by: Philippe Ombredanne <pombredanne@nexB.com?

--
Cordially
Philippe Ombredanne
