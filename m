From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 13:00:24 -0500
Subject: [PATCH 4/5] usb: ohci-da8xx: Remove clock code that references
 mach
In-Reply-To: <Pine.LNX.4.44L0.1603161046300.2250-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1603161046300.2250-100000@iolanthe.rowland.org>
Message-ID: <56E99F38.2050306@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2016 09:50 AM, Alan Stern wrote:

> Is it theoretically impossible for a da8xx platform to have more than
> one OHCI controller?
>
> If it isn't, you better not use static variables to hold per-device
> data.

Yes, it is theoretically impossible, but probably better to not use 
static variables anyway.
