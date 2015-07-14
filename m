From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jul 2015 11:22:07 +0200
Subject: [PATCH v2 0/3] ARM: add UART and EHCI support for UniPhier DTS
 and enable them.
In-Reply-To: <1436504040-16375-1-git-send-email-yamada.masahiro@socionext.com>
References: <1436504040-16375-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150714092207.GF20686@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 01:53:57PM +0900, Masahiro Yamada wrote:
> The basic support for UniPhier SoC family (arch/arm/mach-uniphier)
> was mainlined at Linux 4.2-rc1.
> I am now tackling some drivers to support them in the mainline.
> 
> I've got UART and EHCI done, so I'd like to enable them from
> the ARM-SOC subsystem.
> 
> 
> Changes in v2:
>   - Add chip-specific compatible strings "socionext,uniphier-ehci"
> 

Applied 1-3 to next/dt and next/defconfig. Thanks!


-Olof
