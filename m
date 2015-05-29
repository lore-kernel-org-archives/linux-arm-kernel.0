From: fainelli@broadcom.com (Florian Fainelli)
Date: Fri, 29 May 2015 14:54:04 -0700
Subject: [PATCH v2 6/6] ARM: brcmstb: Add default gpio number
In-Reply-To: <1432865650-4062-7-git-send-email-gregory.0xf0@gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
 <1432865650-4062-7-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <5568DFFC.1020006@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/15 19:14, Gregory Fong wrote:
> Out of the brcmstb SoCs that I know, BCM3390 has the largest numbers
> of GPIOs, with its
> - 320 "peripheral" GPIOs
> - 5*32 = 160 UPG GPIOs (counting unused lines, which do get counted)
> - 2*32 = 64 UPG AON GPIOs (counting unused lines)
> Total: 544
> 
> I suspect that the upper limit will only need to be higher in the
> future, so set it to 1024.
> 
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>

Applied to soc/next, thanks!
-- 
Florian
