From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 12:55:09 +0200
Subject: [PATCH 4/4] dts, altera: Arria10 SDRAM EDAC DTS additions.
In-Reply-To: <1431553787-27741-5-git-send-email-tthayer@opensource.altera.com>
References: <1431553787-27741-1-git-send-email-tthayer@opensource.altera.com>
 <1431553787-27741-5-git-send-email-tthayer@opensource.altera.com>
Message-ID: <5383549.sAl5szqT14@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 16:49:47 tthayer at opensource.altera.com wrote:
> +               sdr: sdr at ffc25000 {
> +                       compatible = "syscon";
> +                       reg = <0xffcfb100 0x80>;
> +               };
> +
> 

A syscon node with just 128 bytes seems very odd. Can you check the
hardware manual to see if this is part of some bigger unit?

	Arnd
