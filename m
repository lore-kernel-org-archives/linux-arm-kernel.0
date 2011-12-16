From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 16 Dec 2011 01:35:18 -0700 (MST)
Subject: [PATCHv8 1/5] OMAP3+: HWMOD: Add the default clockactivity for I2C
In-Reply-To: <1323773758-6375-2-git-send-email-shubhrajyoti@ti.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
 <1323773758-6375-2-git-send-email-shubhrajyoti@ti.com>
Message-ID: <alpine.DEB.2.00.1112160135060.12660@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Dec 2011, Shubhrajyoti D wrote:

> For I2C clockactivity field is added for OMAP3 and OMAP4 that defines how the
> interface (OCP) and functional (system) clocks behave when the I2C module is
> idle.
> 
> The configuration of the clock activity bit field (per TRM) is as follows:
> 0x0: Both clocks can be cut off
> 0x1: Only OCP clock must be kept active; system clock
>      can be cut off
> 0x3: Both clocks must be kept active
> 0x2: Only system clock must be kept active; OCP clock
>      can be cut off
> 
> The patch makes 0x2(CLOCKACT_TEST_ICLK) the default for OMAP3 and OMAP4.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks, queued for 3.3.


- Paul
