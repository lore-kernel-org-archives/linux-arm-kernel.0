From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 24 Oct 2012 11:15:02 +0200
Subject: [PATCH v3 0/4] ARM: dts: Update OMAP5 with address space and
 interrupts
In-Reply-To: <1351062434-22514-1-git-send-email-s-guiriec@ti.com>
References: <1351062434-22514-1-git-send-email-s-guiriec@ti.com>
Message-ID: <5087B196.7090804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Seb,

Sorry, I missed your previous email, your v2 was the right one.
We do have a single INTC in every OMAP, there is no point to repeat the
same data hundred times.
The DTS are already big enough.

On 10/24/2012 09:07 AM, Sebastien Guiriec wrote:
> Since kernel 3.7 the DTS data are not overwriten by hwmod data we can add the address space
> and interrupt line description inside dtsi file for OMAP5. This serie is updating the
> current OMAP5 IP with missing entry.
> 
> It has been tested on OMAP5 with 3.7-audio-display feature tree.
> - MMC is probing and functional
> - TWL6041 probing (GPIO/I2C)
> - booting (UART)
> 
> Update since v1:
> - Add Ack and review
> - Fix up commit messages.
> 
> Update since v2:
> - Add interrupt-parent.

I will take the previous one to avoid the duplication of attributes.

On top of that I will remove the ones introduce in audio IPs for
consistency on OMAP3/4/5 platforms.

Regards,
Benoit
