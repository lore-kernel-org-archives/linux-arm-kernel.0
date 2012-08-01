From: ian.molton@codethink.co.uk (Ian Molton)
Date: Wed, 01 Aug 2012 09:50:57 +0100
Subject: [PATCH v2 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <20120731164652.GD28852@lunn.ch>
References: <1343749529-17571-1-git-send-email-ian.molton@codethink.co.uk>
 <1343749529-17571-4-git-send-email-ian.molton@codethink.co.uk>
 <20120731164652.GD28852@lunn.ch>
Message-ID: <5018EDF1.40709@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 17:46, Andrew Lunn wrote:
> Hi Ian
>
> Probably the driver change will get upstream by netdev. The rest will
> go via the Orion maintainers into arm-soc. So you should probably move
> this board-dt.c change into a patch of its own, or make it part of:
>
> csb1724: Enable device tree based mv643xx ethernet support.
Its not csb1724 specific; I've merged it into

kirkwood: Add a clock setup helper for mv643xx ethernet.

and renamed it to:

kirkwood: Add fixups for DT based mv643xx ethernet.

As this described its purpose better. Hopefully in time, we can
pass something in DT that will allow us to remove that code.

-Ian
