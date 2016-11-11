From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 11 Nov 2016 20:36:40 -0200
Subject: [PATCH] i.MX: Kconfig: Drop errata 769419 for Vybrid
In-Reply-To: <1478709850-9361-1-git-send-email-andrew.smirnov@gmail.com>
References: <1478709850-9361-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5DGkXf6kiLmoE7kheX+vW4HT2F_-RWE3b_BULb8H7zcCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 2:44 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> According to the datasheet, VF610 uses revision r3p2 of the L2C-310
> block, same as i.MX6Q+, which does not require a software workaround for
> ARM errata 769419.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
