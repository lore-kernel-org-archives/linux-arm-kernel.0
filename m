From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 12 Apr 2017 16:53:43 +0200
Subject: [PATCH v2 2/3] power: supply: New driver for LEGO MINDSTORMS EV3
 battery
In-Reply-To: <1491944723-32174-3-git-send-email-david@lechnology.com>
References: <1491944723-32174-1-git-send-email-david@lechnology.com>
 <1491944723-32174-3-git-send-email-david@lechnology.com>
Message-ID: <20170412145343.2bexmzmpovjvgoml@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 11, 2017 at 04:05:22PM -0500, David Lechner wrote:
> This adds a new driver for the LEGO MINDSTORMS EV3 battery. The EV3 is
> an embedded ARM device that can use 6 AA batteries or a special rechargeable
> Li-ion battery pack. The rechargeable battery pack presses a special key
> switch in the battery compartment to indicate that it is present.
> 
> The EV3 is only capable of monitoring battery voltage and current. The
> charging circuit is built into the rechargeable battery pack and there is
> no way to communicate with is, so we can't provide any information about
> charging status.
> 
> When not using the rechargeable battery pack, it is most common to use
> alkaline batteries to power the device, but it is also common for people to
> use rechargeable NiMH batteries. Since there is not a way to automatically
> differentiate between these, the technology property is made writable.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/db3d704e/attachment.sig>
