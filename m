From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 22 Feb 2016 08:42:50 -0800
Subject: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
In-Reply-To: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
References: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
Message-ID: <56CB3A8A.9040401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/02/2016 06:16, Wolfram Sang a ?crit :
> We want the size of the struct, not of a pointer to it. To be future
> proof, just dereference the pointer to get the desired type.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Fixes: dd1aa2524bc5 ("i2c: brcmstb: Add Broadcom settop SoC i2c
controller driver")

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
