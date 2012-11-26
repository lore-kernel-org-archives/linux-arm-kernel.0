From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 26 Nov 2012 10:01:58 -0800
Subject: [PATCH] Input: omap4-keypad: Remove the OMAP4_KBD_SYSCONFIG and
 OMAP4_KBD_SYSSTATUS
In-Reply-To: <1353927079-12493-1-git-send-email-shubhrajyoti@ti.com>
References: <1353927079-12493-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121126180158.GD14623@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 04:21:19PM +0530, Shubhrajyoti D wrote:
> The macros OMAP4_KBD_SYSSTATUS and OMAP4_KBD_SYSSTATUS are not used
> so remove them.

They document the existing registers and do not add bloat to the
generated objects so let's leave them be.

Thanks.

-- 
Dmitry
