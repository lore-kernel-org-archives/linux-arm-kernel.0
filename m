From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 15 Jul 2011 18:40:54 +0800
Subject: [PATCH 07/15] pxa25x_udc: drop support for udc_command
In-Reply-To: <4E1F3450.3050603@free.fr>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
	<1309871321-11305-8-git-send-email-dbaryshkov@gmail.com>
	<20110705134615.GJ2820@legolas.emea.dhcp.ti.com>
	<20110708213428.GA31866@kroah.com>
	<20110708215442.GG31978@legolas.emea.dhcp.ti.com>
	<20110708220258.GA29651@suse.de>
	<CALT56yPuQxY13eAOd9mm7q4A8g6j2mP3F=h-sMv=xwzYzhRQxg@mail.gmail.com>
	<CAMPhdO8vBhod0eWw7dtNSrJHjruoBCZG5KKOHLvJHe+2Y3+TSg@mail.gmail.com>
	<4E1F3450.3050603@free.fr>
Message-ID: <CAMPhdO_f=Mxw9-WgMojLeE8LCbW2tTg7HGcm4NiVJwhseEgjGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not sure if zaurus people can help test it. Pavel?

- eric

On Fri, Jul 15, 2011 at 2:24 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> On 07/14/2011 04:52 AM, Eric Miao wrote:
>>
>> Well, I agree with Dmitry the whole patchset is not related to the GPIO
>> subsystem at all. The major cleanup is actually to the PXA machines,
>> and touches part of the pxa25x_udc driver. If some one Acks the USB
>> part, I can help take the remaining patches.
>
> Ok, I tested the patches for the pxa27x_udc and mioa701 parts.
> Therefore, as it is working, for patches 2, 13, and 15 (reduced to
> pxa27x_udc), I give my :
> Acked-by: Robert Jarzmik <robert.jarzmik@free>
>
> That leaves you with the pxa25x_udc, I'm afraid, but I don't maintain that
> one. Is there an identified maintainer now, or at least someone able to test
> it ?
>
> Cheers.
>
> --
> Robert
>
