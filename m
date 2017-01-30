From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Mon, 30 Jan 2017 14:44:48 -0500
Subject: [PATCH net-next v7 3/3] net: dsa: mv88e6xxx: Add support for
 ethernet switch 88E6141
In-Reply-To: <4a96ab0b31a1617372cdbfab67e7ba585e10f984.1485804488.git-series.gregory.clement@free-electrons.com>
References: <cover.69cbc1ba8937d0fc442538f992d62fc88aa26dcc.1485804488.git-series.gregory.clement@free-electrons.com>
 <4a96ab0b31a1617372cdbfab67e7ba585e10f984.1485804488.git-series.gregory.clement@free-electrons.com>
Message-ID: <874m0gl4cv.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> The Marvell 88E6341 device is single-chip, 6-port Ethernet switch with
> four integrated 10/100/1000Mbps Ethernet transceivers and one high speed
> SerDes interfaces.

I'm sure you meant 88E6141 here ;-)

> It belongs to the Topaz family and unlike the 88E6341 it does not have
> a TCAM.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Thanks,

        Vivien
