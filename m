From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jan 2014 20:12:46 +0100
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <CAOesGMgMnvFAFiO_K4U5n08Tj+ZPWh656D=vgaQOyYbVCyvSDg@mail.gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <201401201958.57997.arnd@arndb.de>
 <CAOesGMgMnvFAFiO_K4U5n08Tj+ZPWh656D=vgaQOyYbVCyvSDg@mail.gmail.com>
Message-ID: <53209494.QWyQq2MDnI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 January 2014 11:04:26 Olof Johansson wrote:
> 
> I'd expect most usage of this to be through gpios, since we're talking
> about external independent modules here. I would prefer not to bring
> in the reset controller stuff here -- it just adds another layer of
> abstraction that seems unnecessary.
> 
> I would prefer if the reset framework was contained to only be the
> on-chip SoC IP block resets, etc, as originally intended.

Ok, fair enough.

	Arnd
