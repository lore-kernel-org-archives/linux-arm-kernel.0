From: davem@davemloft.net (David Miller)
Date: Thu, 18 May 2017 11:02:03 -0400 (EDT)
Subject: [PATCH v3] net: dsa: b53: Add compatible strings for the
 Cygnus-family BCM11360.
In-Reply-To: <20170518003212.4028-1-eric@anholt.net>
References: <20170518003212.4028-1-eric@anholt.net>
Message-ID: <20170518.110203.1473505625966088377.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>
Date: Wed, 17 May 2017 17:32:12 -0700

> Cygnus is a small family of SoCs, of which we currently have
> devicetree for BCM11360 and BCM58300.  The 11360's B53 is mostly the
> same as 58xx, just requiring a tiny bit of setup that was previously
> missing.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to net-next, thanks.
