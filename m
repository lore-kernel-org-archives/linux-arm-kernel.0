From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 8 Dec 2011 17:17:02 +0800
Subject: [MXS MMC v2 2/4] Some cleanups for the MMC driver
In-Reply-To: <d935557e044d2ebc56b4e70487b519fe722e9017.1323328267.git.LW@KARO-electronics.de>
References: <cover.1323328267.git.LW@KARO-electronics.de>
 <d935557e044d2ebc56b4e70487b519fe722e9017.1323328267.git.LW@KARO-electronics.de>
Message-ID: <20111208091701.GC7913@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 09:17:45AM +0100, Lothar Wa?mann wrote:
>  - Remove bogus parens around numerical arguments in #define's
>  - When defining bit masks, use the #def for the shift count
>    instead of repeating the numbers
>  - Remove 'break' at end of switch statement
> 
> Changes wrt v1:
>  - break long lines
>  - leave indentation as is
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Not sure if Chris will ask you to add proper subject prefix though :)

-- 
Regards,
Shawn
