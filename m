From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 7 Jun 2016 13:53:58 -0700
Subject: [PATCH] soc: brcmstb: fix warning from missing include
In-Reply-To: <1465322094-25692-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465322094-25692-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <57573466.3040607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2016 10:54 AM, Ben Dooks wrote:
> The brcmstb_biuctrl_init() is defined in the soc specific header
> file, but wasn't included in the driver file. Fix the following
> warning by including <linux/soc/brcmstb/brcmstb.h> in the driver:
> 
> drivers/soc/brcmstb/biuctrl.c:101:13: warning: symbol 'brcmstb_biuctrl_init' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied, thanks Ben!
-- 
Florian
