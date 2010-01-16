From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 16 Jan 2010 00:16:13 +0000
Subject: Kirkwood/OpenRD-Base System Crash from DMA
References: <20100116001307.GH16062@voodoowarez.com>
Message-ID: <d3d727-505.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rektide <rektide@voodoowarez.com> wrote:
>
> I'm attempting to use 2.6.32.3 on a Kirkwood/OpenRD-Base system.  This 
> system has been serving fine playing MP3's via PulseAudio and MPD for 
> >5 months now.  However other activities will sometime cause the 
> system to lock up.  The most reliable activity is to do a "git pull", 
> from anywhere.  Secondly, writing files onto the system via a Samba 
> share causes a lockup.
> 
> [snipped]
> 
> There's a thread on the OpenRD google group with multiple people confirming the issue:
> http://groups.google.com/group/openrd/browse_thread/thread/d435787eb4e4ffd0
> 
> One person has confirmed the issue goes away when CONFIG_NET_DMA and 
> CONFIG_ASYNC_TX_DMA are disabled.  I'm building a kernel now to 
> confirm this myself, and will report back tomorrow.
> 
I can say it's a "me too" on mine, however I never reported the issue as 
it's a known problem:

http://marc.info/?l=linux-raid&m=123606440522693&w=2

I ran into it on a USB key RAID setup when I started up a huge rsync.  I 
didn't even get a trace in that situation, just a hard lockup.

Not looked at it since.

Cheers

-- 
Alexander Clouter
.sigmonster says: A dwarf is passing out somewhere in Detroit!
