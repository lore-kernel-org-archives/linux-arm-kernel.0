From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 7 Jul 2018 10:52:22 +0200
Subject: [PATCH v3 0/9] Initial support for Samsung Galaxy S and Galaxy S
 4G
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <20180707085222.6z6wihfvg7stfuya@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 08:32:41PM +0200, Pawe? Chmiel wrote:
> This patch series adds support for Samsung Galaxy S and Galaxy S 4G.
> Both are commercial phone based on Aries family.
> 
> Changes from v2:
>   - Restored pinctrl nodes order
>   - Correct order of nodes in aries dtsi file
>   - Added Reviewed-by to one of patches
>   - Added Acked-by to one of patches
>   - Squashed two patches updating samsung-boards documentation 

I applied first DTS patch and last defconfig.  You can resend only the
DTS patches after fixing dtc warnings.  Then I'll apply them with the
bindings change.

Best regards,
Krzysztof
