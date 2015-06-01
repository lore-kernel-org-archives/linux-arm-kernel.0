From: ijc@hellion.org.uk (Ian Campbell)
Date: Mon, 01 Jun 2015 19:07:02 +0100
Subject: [PATCH] ARM: dts: sun6i: Add a dts file for the Mele A1000G
 quad top set box
In-Reply-To: <1433170979-13725-1-git-send-email-hdegoede@redhat.com>
References: <1433170979-13725-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433182022.5748.281.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-06-01 at 17:02 +0200, Hans de Goede wrote:
> The Mele A1000G-quad and the Mele M9 have the same PCB, sofar we've been using
> the same dts for both models. Unfortunately this does not work for the otg
> controller, on the M9 this is routed to a micro-usb connector on the outside,
> while as on the A1000G-quad it is connected to an usb to sata bridge
> (which is not populated on the M9 pcb).
> 
> This commit adds a new dts for the Mele-A1000G-quad to allow using
> different otg controller settings on the 2 boards.

But isn't intending to actually change the otg settings, right?
