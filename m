From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 16 May 2014 19:31:51 +0100
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <20140516041022.GY27822@titan.lakedaemon.net>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <20140511083729.211e9b5f@lwn.net>
 <20140515121546.3A06AC40B0E@trevor.secretlab.ca>
 <CAL_JsqJw11fZBbLVi=xxC559iWdwCMFOJ4XYM-8EjykttoWsOg@mail.gmail.com>
 <20140515194215.GR27822@titan.lakedaemon.net>
 <CAOesGMi0JrTp9kUVDod4duBOCZ+wNRJ0dMmgvBX7jEQRjE5cCA@mail.gmail.com>
 <20140516041022.GY27822@titan.lakedaemon.net>
Message-ID: <1400265111.2647.54.camel@deadeye.wl.decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-05-16 at 00:10 -0400, Jason Cooper wrote:
[...]
> Ok, I assumed *everybody* in the Linux ecosystem went to LinuxCon.  I've
> never actually been to one, but that museum was really crowded in
> Edinburgh.  I figured that _must_ be everybody. :)

I find it rather less useful than Plumbers'.

> Joking aside, I concede your point.  It looks like the last two mvebu
> legacy platforms (dove, mv78xx0) might get merged into mach-mvebu during
> the next cycle.  After that, we can reach out to the Debian and OpenWRT
> guys and see what legacy platforms are in use or rotting.  We can go
> from there.

I just removed ixp4xx from Debian as the kernel image wouldn't fit in
the NSLU2's kernel partition any more (even after disabling quite a few
features that are enabled in most other configurations).  iop32x was
removed for the same reason, a while ago.

Our 'legacy' (which I take to mean pre-v7) configurations are now
kirkwood, mv78xx0, orion5x (all about to converge to mvebu) and
versatile.

Ben.

-- 
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140516/9795766d/attachment.sig>
