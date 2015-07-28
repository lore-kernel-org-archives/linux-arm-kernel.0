From: johan@kernel.org (Johan Hovold)
Date: Tue, 28 Jul 2015 11:24:12 +0200
Subject: [PATCH 4/9] gpio: Add 'name' to the gpio descriptor struct
In-Reply-To: <1437125570-28623-5-git-send-email-mpa@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-5-git-send-email-mpa@pengutronix.de>
Message-ID: <20150728092412.GK28535@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 11:32:45AM +0200, Markus Pargmann wrote:
> The latest gpio hogging mechanism assigns each gpio a 'line-name' in the
> devicetree. The 'name' field is different from the 'label' field.
> 'label' is only used for requested GPIOs to describe its current use by
> driver or userspace.
> 
> The 'name' field describes the GPIO itself, not the use. This is most
> likely identical to the label in the schematic on the GPIO line and
> should help to find this particular GPIO.

You merge this one with whatever patch starts using the name field.

Johan
