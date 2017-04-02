From: stuartl@longlandclan.id.au (Stuart Longland)
Date: Mon, 3 Apr 2017 08:44:04 +1000
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org>
 <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
Message-ID: <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/17 07:41, Nicolas Pitre wrote:
>> No PTYs seems like a big limitation. This means no sshd?
> Again, my ultimate system target is in the sub-megabyte of RAM.  I 
> really doubt you'll be able to fit an SSH server in there even if PTYs 
> were supported, unless sshd (or dropbear) can be made really tiny. 
> Otherwise you most probably have sufficient resources to run the regular 
> TTY code.

Are we talking small microcontrollers here?  The smallest machine in
terms of RAM I ever recall running Linux on was a 386SX/25 MHz with 4MB
RAM, and that had a MMU.

I recall Slackware requiring that you booted with a mounted floppy (no
ramdisk) and possibly even required that you had a second floppy drive
formatted as swap so you'd be able to get through the install without
oomkiller knocking on your door.

The same machine could also "run" Windows 95.  When I say "run", it was
more like a slow crawl.  Bull sharks washed onto land by flood waters
run faster.

Sub-megabyte system support is a noble goal, but I'm wondering how
practical such systems would be, and whether an embedded real-time
kernel might be a better choice than Linux on such systems.
-- 
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/4a0490a2/attachment.sig>
