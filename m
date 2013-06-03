From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 3 Jun 2013 10:28:47 +0800
Subject: [PATCH 31/39] ARM: u300: add syscon node
In-Reply-To: <CACRpkdaPXLuyXWSrMipZs6L973-8C=iaeOWYZ_zCKCSZNn2cQQ@mail.gmail.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <1369991954-17406-32-git-send-email-linus.walleij@stericsson.com>
 <14733989.vf3LkZC316@wuerfel>
 <CACRpkdaPXLuyXWSrMipZs6L973-8C=iaeOWYZ_zCKCSZNn2cQQ@mail.gmail.com>
Message-ID: <20130603022847.GI11753@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Fri, May 31, 2013 at 01:55:56PM +0200, Linus Walleij wrote:
[...]
> But I find no good examples in the kernel on how to grab a
> referenced syscon node and use the regmap API to read/write
> registers :-(
> 
> Dong: do you have some example to point at for this?
> 

No too much in the upstream kernel.
But i think you can see:
arch/arm/mach-imx/mach-imx6q.c
arch/arm/mach-imx/anatop.c
drivers/regulator/anatop-regulator.c

Regards
Dong Aisheng
