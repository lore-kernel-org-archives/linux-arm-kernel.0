From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Sat, 20 Feb 2010 17:41:00 +0100
Subject: [PATCH  0/3] MXC PCMCIA Support
In-Reply-To: <20100220155150.GA3591@n2100.arm.linux.org.uk>
References: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
	<20100220155150.GA3591@n2100.arm.linux.org.uk>
Message-ID: <4B80109C.5080005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> I do wonder whether, as you have windows, you should be using the soc
> support - the soc support is based interfacing hardware which does not
> have windows into the generic infrastructure which assumes the presence
> of windows.
>   
Hi Russell,
Yes I understand what you mean.

I asked on -pcmcia about the approach back in June 2009:
http://marc.info/?l=linux-pcmcia&m=124805223926065&w=2
but didn't get a reply :(

OTOH soc_common provides some other useful stuff like polling thread,
common interrupt handler core, common debug etc.

Cheers,

Martin
