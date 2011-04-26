From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 26 Apr 2011 06:39:24 +0200
Subject: [PATCH v2 23/23] at91: Remove mAgic and ISI device code
In-Reply-To: <4DB08FC5.2@bluewatersys.com>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-24-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D242FC6C@AUSP01VMBX24.collaborationhost.net>
	<4DB08FC5.2@bluewatersys.com>
Message-ID: <20110426043924.GI12904@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08:12 Fri 22 Apr     , Ryan Mallon wrote:
> On 22/04/11 05:33, H Hartley Sweeten wrote:
> > On Wednesday, April 20, 2011 10:42 PM, Ryan Mallon wrote:
> >>
> >> The AT572D940HF mAgic device and the AT91SAM9263 ISI device do not
> >> have drivers yet and therefore the platform code in arch/arm/mach-at91
> >> is unused and can be removed.
> > 
> > Is anyone planning on adding these drivers?
> > 
> > I wonder if it makes sense to add the infrastructure to devices.[ch] and
> > convert the users even it the drivers are not in mainline yet?
> 
> I removed them because there is currently a push to reduce the size of
> the ARM tree. The ISI code has been there since 2008 and the mAgic
> device code since 2009 without drivers. The ISI device at least is
> supported on more than one variant, but only had code present for the
> AT91SAM9263.
> 
> I think it is better to remove them now, and then if/when drivers get
> added the support code can be added to the common framework.
NACK I do not want to remove code just to reduce line code for soc

factorize ok
remove soc resources no

for the ISI I plan to add it but I work on something else by now

and some patch have already been send to the v4l ML

Best Regards,
J.
