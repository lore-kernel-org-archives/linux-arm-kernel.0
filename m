From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 28 Nov 2014 23:43:34 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141128222630.GA1382@fuloong-minipc.musicnaut.iki.fi>
References: <20141027200008.GR2560@atomide.com> <201411282241.12095@pali>
 <20141128222630.GA1382@fuloong-minipc.musicnaut.iki.fi>
Message-ID: <201411282343.34538@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 23:26:30 Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Nov 28, 2014 at 10:41:12PM +0100, Pali Roh?r wrote:
> > Does kernel provide some interface for telling userspace
> > applications something like bootreason (e.g power key,
> > software reset, rtc alarm, charger connected, ...)?
> 
> In N950/N9, NOLO passes this information using kernel command
> line and applications are reading /proc/cmdline. If I
> remember correctly all those custom proc files were removed
> from Nokia kernel, and everything was passed via command
> line.
> 
> A.

Yes, you are right. But NOLO on N900 pass all those data via 
ATAGs only and does not pass it in /proc/cmdline :-(

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/6e74d218/attachment.sig>
