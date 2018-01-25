From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 25 Jan 2018 21:11:03 +0530
Subject: [RESEND] phy: da8xx-usb: rename clock con_ids
In-Reply-To: <1516731283-26388-1-git-send-email-david@lechnology.com>
References: <1516731283-26388-1-git-send-email-david@lechnology.com>
Message-ID: <dbf02743-10ee-ccce-5f9c-2be8de075832@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 January 2018 11:44 PM, David Lechner wrote:
> This renames the clock con_ids in the DA8XX USB PHY driver as well as
> the matching names in the mach clock registration code.
> 
> This is in preparation for using device tree clocks where these names
> will become part of the device tree bindings. The new names more closely
> match the names used in the USB clock diagram in the SoC TRM.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Looks good to me.

Kishon, like with the other patch touching phy-da8xx-usb.c, I would like
to queue this through my tree and provide an immutable commit to you.
Let me know.

Thanks,
Sekhar
