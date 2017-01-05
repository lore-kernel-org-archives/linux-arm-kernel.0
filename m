From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 05 Jan 2017 15:25:53 +0100
Subject: [PATCH net-next v4 0/2] Add support for the ethernet switch on
 the ESPRESSObin
In-Reply-To: <20161221125734.1034-1-romain.perier@free-electrons.com> (Romain
 Perier's message of "Wed, 21 Dec 2016 13:57:32 +0100")
References: <20161221125734.1034-1-romain.perier@free-electrons.com>
Message-ID: <87tw9dbn2m.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,
 
 On mer., d?c. 21 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

> This set of patches adds support for the Marvell ethernet switch 88E6341.
> It also add the devicetree definition of this switch to the DT board.

The forth version of this series had been sent while the net-next merge
window was closed so I think it was missed.

Do you want that we send it again on the netdev mainling list?

Thanks,

Gregory

>
> Romain Perier (2):
>   net: dsa: mv88e6xxx: Don't forbid MDIO I/Os for PHY addr >=
>     num_of_ports
>   net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341/88E6141
>
>  drivers/net/dsa/mv88e6xxx/chip.c      | 48 ++++++++++++++++++++++++++++++-----
>  drivers/net/dsa/mv88e6xxx/mv88e6xxx.h |  4 ++-
>  2 files changed, 45 insertions(+), 7 deletions(-)
>
> -- 
>
> Note: As requested by Gregory, I have removed the patch for the DT (already merged).
>
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
