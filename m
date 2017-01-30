From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 30 Jan 2017 17:07:47 -0200
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <20170130185444.GF27312@n2100.armlinux.org.uk>
References: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
 <20170119141335.kpbrbpbwaovnijjv@pengutronix.de>
 <CAOMZO5AdgM9eFnerLRdYxwE7gsOE5OvkWs6rCR4zta1XmXHj1A@mail.gmail.com>
 <20170119144641.jxj2bqg5uqjol23x@pengutronix.de>
 <20170119145642.GC27312@n2100.armlinux.org.uk>
 <20170119161441.jcctgig7np4v7sam@pengutronix.de> <588914F3.7050909@gmail.com>
 <20170130185444.GF27312@n2100.armlinux.org.uk>
Message-ID: <CAOMZO5BZwMXL-6_vOVjqpBn9wrPuH4BsBB_2vwKF-fe6iaHzYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 4:54 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> We need this regression fixed before 4.10 comes out so systems don't
> break when 4.10 comes out.

It will be fixed in the next rc with the following commit:
https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/fixes&id=a971c5545c3d45a1e33fda6e57913bb75aaa20c9
