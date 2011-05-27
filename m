From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 May 2011 07:57:23 -0700
Subject: [PATCH 0/3] Some omap_device/hwmod/pwrdomain patches
In-Reply-To: <1306474266.1905.8.camel@deskari> (Tomi Valkeinen's message of
	"Fri, 27 May 2011 08:31:06 +0300")
References: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com>
	<87ipsxfjyd.fsf@ti.com> <1306474266.1905.8.camel@deskari>
Message-ID: <874o4g6vjg.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

[...]

>
>> This isn't something in general that drivers should be aware of, so I'd
>> rather not see this exposed to drivers (unless there's a real need.)
>
> Ok, I'll drop the patch. I don't think there's any need for this in DSS.
>
>> As soon as I finish the move to device power domains (hopefully for
>> 2.6.41), the driver's callbacks will only be called if the device has
>> lost context, so checking for context loss will not be needed at all at
>> the driver level.
>
> This sounds good. Runtime PM's suspend & resume callbacks or something
> else? 

Runtime PM callbacks.

Kevin
