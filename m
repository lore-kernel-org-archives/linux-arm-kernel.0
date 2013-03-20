From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 20 Mar 2013 10:32:51 +0000
Subject: TI users about to be banned from all lists.infradead.org mailing
 lists (was Re: [LAKML][Users getting knocked of from list])
In-Reply-To: <5149735D.8070001@ti.com>
References: <51495574.4080501@ti.com> <51495A67.80206@ti.com>
 <5149735D.8070001@ti.com>
Message-ID: <1363775571.26810.51.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-20 at 13:59 +0530, Santosh Shilimkar wrote:
> On Wednesday 20 March 2013 12:12 PM, Sekhar Nori wrote:
> > I have no clue why my address should bounce.
> > 
> Me neither.

TI's incoming mail appears to be broken. For days at a time, it is
simply giving a '421 Service Temporarily Unavailable' error to incoming
mail.

This is a *temporary* error, so the messages sit on the list server's
queue until they time out (5 or 7 days, IIRC) and then are finally
considered to have bounced. I currently have 38865 messages for 32
separate @ti.com recipients clogging up the mail queue.

Here are some recent failed delivery attempts:

2013-03-20 09:18:41 +0000 1UIF8B-00011C-7Q == santosh.shilimkar at ti.com R=lookuph
ost T=verp_smtp defer (-44): SMTP error from remote mail server after RCPT TO:<s
antosh.shilimkar@ti.com>: host cluster5a.us.messagelabs.com [216.82.251.230]: 42
1 Service Temporarily Unavailable

2013-03-20 09:33:49 +0000 1UDY5k-0002SY-Po == nsekhar at ti.com R=lookuphost T=verp
_smtp defer (-44): SMTP error from remote mail server after RCPT TO:<nsekhar@ti.
com>: host cluster5a.us.messagelabs.com [216.82.251.230]: 421 Service Temporaril
y Unavailable

Please report this to your IT department (it looks like it might be a
problem at messagelabs.com rather than in-house), and be aware that I am
on the verge of just banning *all* @ti.com addresses from all lists
until it's fixed. 

I wonder if you'll even receive this message, but perhaps you'll see it
in the archives?

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6171 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130320/49aa48b4/attachment.bin>
