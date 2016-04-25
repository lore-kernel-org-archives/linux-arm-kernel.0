From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 01:14:34 +0200
Subject: [PATCH] soc: brcmstb: Unmap sun_top_ctrl_base on errors
In-Reply-To: <1461625693-22793-1-git-send-email-f.fainelli@gmail.com>
References: <1461625693-22793-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <6953436.B3Mfs8t6Nm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 April 2016 16:08:09 Florian Fainelli wrote:
> Do not leak a ioremap()'d cookie around, unmaping it in case of errors
> 
> Fixes: cef4bafcea2c ("soc: brcmstb: add SoC driver to brcmstb")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

I've applied it on top now, along with my fix, thanks!

	Arnd
