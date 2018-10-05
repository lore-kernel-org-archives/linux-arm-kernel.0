From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 4 Oct 2018 20:38:21 -0700
Subject: [PATCH] ARM: KVM: Correctly order SGI register entries in the
 cp15 array
In-Reply-To: <20181004092946.59836-1-marc.zyngier@arm.com>
References: <20181004092946.59836-1-marc.zyngier@arm.com>
Message-ID: <f32a99ed-a37b-889a-bab5-0faa9bd8fb42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/04/18 ? 02:29, Marc Zyngier a ?crit?:
> The ICC_ASGI1R and ICC_SGI0R register entries in the cp15 array
> are not correctly ordered, leading to a BUG() at boot time.
> 
> Move them to their natural location.
> 
> Fixes: 3e8a8a50c7ef ("KVM: arm: vgic-v3: Add support for ICC_SGI0R and ICC_ASGI1R accesses")
> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
