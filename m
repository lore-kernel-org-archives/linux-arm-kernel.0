From: julien.boibessot@free.fr (Julien Boibessot)
Date: Fri, 14 Jan 2011 10:17:09 +0100
Subject: [PATCH v2] i.MX51 Framebuffer support
In-Reply-To: <20110106094237.GB31708@n2100.arm.linux.org.uk>
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	<4D246C54.9060503@free.fr>
	<20110106094237.GB31708@n2100.arm.linux.org.uk>
Message-ID: <4D301495.3050906@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux a ?crit :
> On Wed, Jan 05, 2011 at 02:04:20PM +0100, Julien Boibessot wrote:
>   
>> The only strange thing I noticed was a kind of uggly sprite/artefact
>> (32x32, I would say) appearing at the same time as the Linux console. I
>> think it may be related to a hardware cursor badly (?) initialised, but
>> I didn't find a fix yet.
>> It disappears when I launch a graphical application (Qt or SDL).
>>     
>
> In the top left corner?  That'll be the linux penguin logo, and if it's
> not coming out correctly, your framebuffer driver is badly broken.
> Maybe your RGB bitfield information or visual is wrong?
>   
Sorry for my late answer...
Penguin logo is OK, the artefact is just under the penguin and is
looking like a blinking cursor until login message is displayed. At that
time it becomes a kind of uggly rectangular black and white lines mix,
overlapping logging message.
I will follow Sascha's advise and try to play with i.MX51 hardware cursor.

Regards,
Julien
