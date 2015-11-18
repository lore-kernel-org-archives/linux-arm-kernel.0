From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Nov 2015 10:39:30 -0800
Subject: [PATCH 03/11] dts: pinctrl: Add GPIO to Pinctrl pin mapping in DT
In-Reply-To: <1445233398-27129-4-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-4-git-send-email-pramodku@broadcom.com>
Message-ID: <564CC5E2.2070809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/15 22:43, Pramod Kumar wrote:
> ASIU gpio controller's pins are muxed with pin-cntroller.
> Add this mapping through property "gpio-ranges".
> 
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Applied to devicetree/next, since there was a bit of restructuring, I
had to manually apply it, please verify the resolution looks correct to you.

Thanks!
-- 
Florian
