From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 24 Apr 2017 14:51:13 -0700
Subject: [PATCH 1/2] net: dsa: b53: Add compatible strings for the
 Cygnus-family BCM11360.
In-Reply-To: <20170424215022.30382-2-eric@anholt.net>
References: <20170424215022.30382-1-eric@anholt.net>
 <20170424215022.30382-2-eric@anholt.net>
Message-ID: <b3aa7bcb-cd11-2159-f6c0-9888dff22e28@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2017 02:50 PM, Eric Anholt wrote:
> Cygnus is a small family of SoCs, of which we currently have
> devicetree for BCM11360 and BCM58300.  The 11360's B53 is mostly the
> same as 58xx, just requiring a tiny bit of setup that was previously
> missing.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
