From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 18 Sep 2016 12:37:45 -0700
Subject: [PATCH v4] MIPS: bcm63xx: let clk_disable() return immediately if
 clk is NULL
In-Reply-To: <1474221875-22687-1-git-send-email-yamada.masahiro@socionext.com>
References: <1474221875-22687-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <d70c5d6c-1648-ba19-627f-c5fb374ad112@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/09/2016 ? 11:04, Masahiro Yamada a ?crit :
> In many of clk_disable() implementations, it is a no-op for a NULL
> pointer input, but this is one of the exceptions.
> 
> Making it treewide consistent will allow clock consumers to call
> clk_disable() without NULL pointer check.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
