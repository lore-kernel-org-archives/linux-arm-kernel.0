From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sat, 6 Dec 2014 19:08:46 +0100
Subject: N900: fixing MMC at boot
In-Reply-To: <20141206180429.GA312@amd>
References: <20141206173526.GA7964@amd> <201412061840.16157@pali>
 <20141206180429.GA312@amd>
Message-ID: <201412061908.46854@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 December 2014 19:04:29 Pavel Machek wrote:
> On Sat 2014-12-06 18:40:16, Pali Roh?r wrote:
> > On Saturday 06 December 2014 18:35:27 Pavel Machek wrote:
> > > Hi!
> > > 
> > > For a long time, MMC was not working during boot...
> > > (making the box unusable without nfsroot). It seems
> > > problem is in the regulators, because with diff below, I
> > > was able to mount root on SD card for a first time ... in
> > > a long time.
> > 
> > Hi, do you mean external SD card or internal eMMC (MyDocs)?
> 
> I mean u-SD card. But it is strange. I reverted the patch now,
> and it still works. Not sure why or what I've done
> differently.
> 
> 									Pavel

Remove battery wait some time and try again. Maybe you configured 
something which can be cleared only after full device shutdown...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141206/2653f272/attachment.sig>
