From: bcousson@baylibre.com (Benoit Cousson)
Date: Wed, 14 Aug 2013 15:51:01 +0200
Subject: [PATCH v2 0/2] omap4/twl6030: typical connection to omap4 as
 a separate dtsi file
In-Reply-To: <1376469348-10797-1-git-send-email-ruslan.bilovol@ti.com>
References: <1376469348-10797-1-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <520B8B45.1010300@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ruslan,

On 14/08/2013 10:35, Ruslan Bilovol wrote:
> Hello,
>
> There is no functional changes between v1 and v2 - just
> added the patch for omap4-var-som - Uri Yosef confirmed
> this board have the same connection of OMAP4<->TWL6030 as
> SDP4430 board

The series looks good to me, but it will be good to have a test for 
Panda and Variscite boards before merging it.

Regards,
Benoit
