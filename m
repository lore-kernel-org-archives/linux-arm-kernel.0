From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 23 Jul 2012 12:38:33 -0600 (MDT)
Subject: [PATCHv7 09/12] ARM: OMAP4: hwmod data: temporarily comment out
 data for the sl2if IP block
In-Reply-To: <1342704392-23657-10-git-send-email-t-kristo@ti.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com>
 <1342704392-23657-10-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1207231236210.10781@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero

On Thu, 19 Jul 2012, Tero Kristo wrote:

> The OMAP4 sl2if IP block requires some special programming for it to
> enter idle. Without this programming, they will prevent the rest of
> the chip from entering full chip idle.
> 
> This patch comments out the IP block data.
> 
> Later, once the appropriate support is available, this patch can be
> reverted.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Originally I was hoping that we could apply a real fix for this one.  But 
looking at the proposed alternative in the old SL2IF E-mail threads, I'm 
still not convinced by what's proposed there.  So we'd better take this 
one for the time being.

Queued for 3.6-rc.

- Paul
