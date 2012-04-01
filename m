From: cjb@laptop.org (Chris Ball)
Date: Sat, 31 Mar 2012 23:49:19 -0400
Subject: [PATCH 0/4] atmel-mci device tree support
In-Reply-To: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
 (ludovic desroches's message of "Wed, 21 Mar 2012 19:03:10 +0100")
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <87iphkm7r4.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 21 2012, ludovic.desroches at atmel.com wrote:
> Hi,
>
> This patch-set adds device tree support for atmel-mci.

Please can you resend after syncing up with Arnd's suggestions in:
   http://thread.gmane.org/gmane.linux.kernel.samsung-soc/9216/focus=13659

(It looks like the main difference is just s/cd-invert;/cd-inverted;/.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
