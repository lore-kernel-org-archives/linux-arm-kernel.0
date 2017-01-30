From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Mon, 30 Jan 2017 14:43:48 -0500
Subject: [PATCH net-next v7 2/3] net: dsa: mv88e6xxx: Add support for
 ethernet switch 88E6341
In-Reply-To: <e3122f300fd144e2b4ae299d74fe1e72389583bb.1485804488.git-series.gregory.clement@free-electrons.com>
References: <cover.69cbc1ba8937d0fc442538f992d62fc88aa26dcc.1485804488.git-series.gregory.clement@free-electrons.com>
 <e3122f300fd144e2b4ae299d74fe1e72389583bb.1485804488.git-series.gregory.clement@free-electrons.com>
Message-ID: <877f5cl4ej.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> The Marvell 88E6341 device is single-chip, 6-port Ethernet switch with
> four integrated 10/100/1000Mbps Ethernet transceivers and one high speed
> SerDes interfaces. It is partially compatible with switches of family
> 88E6352 and switches of family 88E6390.
>
> This commit adds an initial support for this switch by describing its
> capabilities to the driver and introducing a new family.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Thanks,

        Vivien
