From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 7 Jul 2018 10:38:52 +0200
Subject: [PATCH v3 1/9] ARM: dts: s5pv210: Add missing
 interrupt-controller property to gph2
In-Reply-To: <1530901970-14972-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530901970-14972-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <20180707083852.sqjfcxyicilwekuv@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 08:32:42PM +0200, Pawe? Chmiel wrote:
> Adds missing interrupt-controller property to gph2 block,
> to silence following warnings during build
>   /soc/pinctrl at e0200000/gph2: Missing interrupt-controller or interrupt-map property
> 
> It's reguired by Samsung aries boards, an S5PV210 based
> Samsung Galaxy S (i9000) and Galaxy S 4G phones, which are added in next patches.
> 
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks, applied.

Best regards,
Krzysztof
