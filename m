From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 13 May 2017 11:26:57 -0700
Subject: [PATCH 3/4] ARM: ep93xx: tidy up TS-72xx Watchdog resources
In-Reply-To: <20170221181529.6780-4-hsweeten@visionengravers.com>
References: <20170221181529.6780-1-hsweeten@visionengravers.com>
 <20170221181529.6780-4-hsweeten@visionengravers.com>
Message-ID: <592ffce9-e1e6-0bb1-628e-75a09c595fc6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/21/17 ? 10:15, H Hartley Sweeten a ?crit :
> The ts-72xx watchdog uses two byte sized registers. Tidy up the resource
> declaration so that the proper information is shown in /proc/iomem.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
