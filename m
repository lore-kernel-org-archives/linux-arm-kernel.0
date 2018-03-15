From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 15:56:28 +0100
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.17
In-Reply-To: <CACPK8Xfv2XnhGo9cmJC69suOu9+caOp5QoXuD5Xw-gznGP61Og@mail.gmail.com>
References: <CACPK8Xfv2XnhGo9cmJC69suOu9+caOp5QoXuD5Xw-gznGP61Og@mail.gmail.com>
Message-ID: <CAK8P3a1DiNgdLhAYKf2gjHCzW_6v8Kv9FNHXZ8KeBti8hycVuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 7:42 AM, Joel Stanley <joel@jms.id.au> wrote:
> ASPEED device tree updates for 4.17
>
> Updates to OpenPower BMC systems:
>
>  A number of updates to use recently merged drivers, including moving to
>  upstreamed IPMI BT nodes, a temp sensor for Romulus, and adding
>  simple-reset for UARTs.
>
>  This includes more of Palmetto's device tree, so that it's ever so
>  close to booting the host with an upstream kernel.
>
> New machines:
>
>  Add Qualcomm Centriq ARM64 server reference platform, which will run
>  OpenBMC on an AST2500.

Pulled into next/dt, thanks!

        Arnd
