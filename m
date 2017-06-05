From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 5 Jun 2017 09:47:31 -0700
Subject: [PATCH v3 2/2] ARM: dts: Add the ethernet and ethernet PHY to the
 cygnus core DT.
In-Reply-To: <20170428222204.7103-2-eric@anholt.net>
References: <20170428222204.7103-1-eric@anholt.net>
 <20170428222204.7103-2-eric@anholt.net>
Message-ID: <8d6084ac-869b-6ac6-418a-4be843c27ef3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2017 03:22 PM, Eric Anholt wrote:
> Cygnus has a single amac controller connected to the B53 switch with 2
> PHYs.  On the BCM911360_EP platform, those two PHYs are connected to
> the external ethernet jacks.
> 
> v2: Call the node "switch", just call the ports "port" (suggestions by
>     Florian), drop max-speed on the phys (suggestion by Andrew Lunn),
>     call the other nodes "ethernet" and "ethernet-phy" (suggestions by
>     Sergei Shtylyov)
> v3: Drop another max-speed (Andrew), keep mdio disabled in the shared
>     dtsi (Florian)
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks Eric!
-- 
Florian
