From: mpfj-list@newflow.co.uk (Mark Jackson)
Date: Fri, 04 Oct 2013 09:09:02 +0100
Subject: [PATCH v3] Add support for Newflow NanoBone board
In-Reply-To: <524298FE.4090200@newflow.co.uk>
References: <524298FE.4090200@newflow.co.uk>
Message-ID: <524E779E.5040804@newflow.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/13 09:04, Mark Jackson wrote:
> NanoBone Specification:
> -----------------------
> CPU:
>   TI AM335x
> 
> Memory:
>   256MB DDR3
>   128MB NOR flash
>   128KB FRAM
> 
> Ethernet:
>   2 x 10/100 connected to SMSC LAN8710 PHY
> 
> USB:
>   1 x USB2.0 Type A
> 
> I2C:
>   2Kbit EEPROM (Microchip 24AA02)
>   RTC (Maxim DS1338)
>   GPIO Expander (Microchip MCP23017)
> 
> Expansion connector:
>   6 x UART
>   1 x MMC/SD
>   1 x USB2.0
> 
> Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

<snip>

Any chance someone could accept / comment on this patch ?

Cheers
Mark J.
