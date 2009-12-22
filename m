From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 22 Dec 2009 09:12:33 -0700 (MST)
Subject: [PATCH 1/1] ARM: OMAP4: PM: Remove the checks preventing OMAP4
	clockdomain validation
In-Reply-To: <1261391747-24066-1-git-send-email-abhijitpagare@ti.com>
References: <1261391747-24066-1-git-send-email-abhijitpagare@ti.com>
Message-ID: <alpine.DEB.2.00.0912220911160.5563@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abhijit,

On Mon, 21 Dec 2009, Abhijit Pagare wrote:

> The clockdomain related code beng in place it is now not necessary to have
> some of the clock code commented out. This would help the validation of the
> clockdomain functions using the clock level interfaces.
> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Could you also deal with the TODO in mach-omap2/clock44xx_data.c ?

Also, has this patch been tested?  If so, please list the platform it was 
tested on in the commit message.

thanks,

- Paul
