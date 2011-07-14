From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 14 Jul 2011 21:01:14 +0200
Subject: [PATCH 07/15] pxa25x_udc: drop support for udc_command
In-Reply-To: <4E1F3450.3050603@free.fr>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>	<1309871321-11305-8-git-send-email-dbaryshkov@gmail.com>	<20110705134615.GJ2820@legolas.emea.dhcp.ti.com>	<20110708213428.GA31866@kroah.com>	<20110708215442.GG31978@legolas.emea.dhcp.ti.com>	<20110708220258.GA29651@suse.de>	<CALT56yPuQxY13eAOd9mm7q4A8g6j2mP3F=h-sMv=xwzYzhRQxg@mail.gmail.com>	<CAMPhdO8vBhod0eWw7dtNSrJHjruoBCZG5KKOHLvJHe+2Y3+TSg@mail.gmail.com>
	<4E1F3450.3050603@free.fr>
Message-ID: <4E1F3CFA.7080101@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2011 08:24 PM, Robert Jarzmik wrote:
> On 07/14/2011 04:52 AM, Eric Miao wrote:
>> Well, I agree with Dmitry the whole patchset is not related to the GPIO
>> subsystem at all. The major cleanup is actually to the PXA machines,
>> and touches part of the pxa25x_udc driver. If some one Acks the USB
>> part, I can help take the remaining patches.
>
And I forgot patch 12 :
Acked-by: Robert Jarzmik <robert.jarzmik@free>

Cheers.

--
Robert
