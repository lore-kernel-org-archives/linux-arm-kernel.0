From: davem@davemloft.net (David Miller)
Date: Sun, 30 Apr 2017 22:48:52 -0400 (EDT)
Subject: [PATCH v3 1/2] net: dsa: b53: Add compatible strings for the
 Cygnus-family BCM11360.
In-Reply-To: <20170428222204.7103-1-eric@anholt.net>
References: <20170428222204.7103-1-eric@anholt.net>
Message-ID: <20170430.224852.172293736555378453.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>
Date: Fri, 28 Apr 2017 15:22:03 -0700

> Cygnus is a small family of SoCs, of which we currently have
> devicetree for BCM11360 and BCM58300.  The 11360's B53 is mostly the
> same as 58xx, just requiring a tiny bit of setup that was previously
> missing.
> 
> v2: Reorder the entry in the docs (suggestion by Scott Branden), add
>     missing '"'
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

The second patch with the DTS file update doesn't apply cleanly
at all to net-next.

So I'm dropping this series.
