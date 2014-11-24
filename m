From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 24 Nov 2014 23:21:55 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <20140618211038.GD558@drone.musicnaut.iki.fi>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201406182122.29623@pali> <20140618211038.GD558@drone.musicnaut.iki.fi>
Message-ID: <201411242321.55626@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 June 2014 23:10:39 Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Jun 18, 2014 at 09:22:29PM +0200, Pali Roh?r wrote:
> > So without this patch DT migration for Nokia N900 cannot be
> > done without breaking userspace - which is not
> > acceptable...
> 
> I guess the fact is that the Nokia N900 proprietary userspace
> has never worked properly with the mainline kernel without
> severe patching, so you cannot really talk about any
> regression. If you cannot fix those programs, you could still
> probably emulate the old Nokia kernel's /proc/cpuinfo by
> providing some text file and bind mounting it, no?
> 
> A.

Mainline kernel (with patches for missing driver) working with 
Maemo CSSU-Devel userspace. So there are regressions.

Emulation of /proc/cpuinfo is possible if somebody provides 
needed info. But I still do not know from *where* to read 
machine, serial number and hw revision.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/aa667d0d/attachment.sig>
