From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 18 Sep 2015 12:23:12 -0700
Subject: [PATCH v2 3/3] ARM: brcmstb: Setup BIU control registers during
 boot
In-Reply-To: <1442340900-15320-4-git-send-email-f.fainelli@gmail.com>
References: <1442340900-15320-1-git-send-email-f.fainelli@gmail.com>
 <1442340900-15320-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <55FC64A0.3050700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/15 11:15, Florian Fainelli wrote:
> Call brcmstb_biuctrl_init() in brcmstb's init_irq machine descriptor
> callback since we need to setup the Bus Interface Unit before SMP in
> particular, but we also need to be able to remap registers.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to soc/next.
-- 
Florian
