From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 28 Feb 2017 12:29:25 -0800
Subject: [PATCH] soc: bcm: brcmstb: Match additional compatible strings
In-Reply-To: <20170215004159.11096-1-florian.fainelli@broadcom.com>
References: <20170215004159.11096-1-florian.fainelli@broadcom.com>
Message-ID: <3df8fb67-1809-3781-6f7b-b1057b137f40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2017 04:41 PM, Florian Fainelli wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> Match all known sun-top-ctrl compatible strings from our MIPS chips
> counterparts. This allows us to properly report the SoC information to
> user-space through our SoC driver.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.

> ---
> Ralf, James,
> 
> I usually take patches touching this file through an ARM SoC pull request,
> posting to linux-mips for people working on BMIPS STB to get a chance to review
> this.
> 
> Thanks!
-- 
Florian
