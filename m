From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 May 2018 10:18:56 +0100
Subject: [PATCH net-next v3 00/10] net: mvpp2: phylink conversion
In-Reply-To: <20180517082939.14598-1-antoine.tenart@bootlin.com>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
Message-ID: <20180517091856.GA17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 10:29:29AM +0200, Antoine Tenart wrote:
> Since v2:
>   - Removed the SFP description from the DB boards, as their SFP cages
>     are wired properly. We now use fixed-link.

I think you mean "improperly" here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
