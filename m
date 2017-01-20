From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Thu, 19 Jan 2017 20:54:39 -0500
Subject: [PATCH v5 1/2] net: dsa: mv88e6xxx: Don't forbid MDIO I/Os for
 PHY addr >= num_of_ports
In-Reply-To: <20170120000645.GA31483@lunn.ch>
References: <20170119214934.27442-1-gregory.clement@free-electrons.com>
 <20170119214934.27442-2-gregory.clement@free-electrons.com>
 <871svylmvb.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
 <20170120000645.GA31483@lunn.ch>
Message-ID: <87d1fi1oo0.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Andrew Lunn <andrew@lunn.ch> writes:

>> Isn't there an hardware table used to map the PHY addresses on such chip?
>
> The 6390 has something like this. But if we can avoid it, lets keep it
> KISS.

I definitely agree. I was just curious about this new chip.

Thanks,

        Vivien
