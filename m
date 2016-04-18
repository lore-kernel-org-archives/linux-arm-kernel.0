From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 18 Apr 2016 14:21:01 -0700
Subject: [PATCH v2] bus: brcmstb_gisb: Rework dependencies
In-Reply-To: <1460839575-16869-1-git-send-email-f.fainelli@gmail.com>
References: <1460839575-16869-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <57154FBD.9080903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/04/16 13:46, Florian Fainelli wrote:
> Do not have the machine Kconfig entry point need to select
> BRCMSTB_GISB_ARB, instead, just let it be default ARCH_BRCMSTB which is
> a better way to deal with this. While at it, also make it default
> BMIPS_GENERIC so the legacy MIPS-based STB platforms can benefit from
> the same thing.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to drivers/next
-- 
Florian
