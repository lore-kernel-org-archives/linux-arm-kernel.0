From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 3 Jul 2012 12:05:21 +0100
Subject: [PATCH V2 5/6] x86: add CONFIG_ARM_AMBA, selected by STA2X11
In-Reply-To: <4FF1F987.3030501@zytor.com>
References: <4FECB95D.7010200@zytor.com> <20120701104401.GA4352@mail.gnudd.com>
 <2b797c83-6a3c-4051-841a-a4cfa9d1cae1@email.android.com>
 <201207021658.27755.arnd@arndb.de>
 <20120702180518.GA25995@sirena.org.uk> <4FF1E37D.7050103@zytor.com>
 <20120702183324.GA29030@opensource.wolfsonmicro.com>
 <4FF1F987.3030501@zytor.com>
Message-ID: <20120703110520.GI29030@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 12:41:59PM -0700, H. Peter Anvin wrote:
> On 07/02/2012 11:33 AM, Mark Brown wrote:

> >> Last I saw I saw a patch to that effect, asked what the benefit
> >> was, and got no answer.

> > Are you positive about that?  I don't recall you replying any of
> > the times I sent out the patch and my mail archive isn't
> > contradicting me either.

> I said last time I saw a patch to that effect; it might not have been
> from you.  I might not have seen yours for whatever reason (including
> losing it on my end.)

I'm kind of surprised anyone else has been sending stuff (unless mine
got resent by someone else, I did include it in some of my serises for
the clock API); I know I've posted mine several times now.  In any case,
I hope the mail you're replying to answers your question about why it's
useful.

In general I'd probably go further and say that (at least when a generic
implementation is available) there should be a very good reason for not
enabling an API on an architecture rather than the other way around.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120703/38f6f475/attachment.sig>
