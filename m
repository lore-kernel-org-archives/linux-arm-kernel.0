From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 18 Jun 2014 22:20:22 +0200
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <20140618200053.GK32514@n2100.arm.linux.org.uk>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201406182122.29623@pali> <20140618200053.GK32514@n2100.arm.linux.org.uk>
Message-ID: <201406182220.22818@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 June 2014 22:00:54 Russell King - ARM Linux 
wrote:
> On Wed, Jun 18, 2014 at 09:22:29PM +0200, Pali Roh?r wrote:
> > So without this patch DT migration for Nokia N900 cannot be
> > done without breaking userspace - which is not
> > acceptable...
> > 
> > Also I still did not know why DT kernel does not report
> > Revision number which is passed by bootloader via atags.
> > Any idea?
> 
> It was a concious decision by the DT people to exclude most of
> the ATAGs which provide that information.  Only memory
> information and command line ATAGs are merged into DT.  Every
> other tag is ignored (as there's no place for it in DT.)

So how to read Revision and Serial number in DT based kernel? 

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/b648a269/attachment.sig>
