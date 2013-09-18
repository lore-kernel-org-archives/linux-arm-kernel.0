From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Sep 2013 11:25:39 -0500
Subject: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
In-Reply-To: <20130918143537.GA4914@amd.pavel.ucw.cz>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309172128.42514@pali> <20130918014942.GD19817@radagast>
 <201309181020.15245@pali>
 <CAAwP0s1Ou7Nrq7GhnHX71TFCrTFg=nqUh+GsAJhN8DjZGsF4QQ@mail.gmail.com>
 <20130918133025.GB2953@amd.pavel.ucw.cz>
 <CAAwP0s0nGthkm9Bp1ug23Rtz6-sbR60FFTSfd-Cj9wKMU0RBEA@mail.gmail.com>
 <20130918142203.GD3748@amd.pavel.ucw.cz>
 <20130918143537.GA4914@amd.pavel.ucw.cz>
Message-ID: <20130918162539.GK21559@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 18, 2013 at 04:35:37PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > gave feedback. If the sender doesn't want to take his feedback into
> > > account and prefer to send pretty insulting emails instead that is his
> > > choice but I would say that is this not the greatest approach to get
> > > your code merged (to say the least).
> > 
> > Clearly not. But Pali found bug in code Felipe should
> > maintain. Instead of "thank you for bug report, I applied this one
> > line of your code to fix it", Pali got "new patch, new email" for his
> > efforts. That is how you train dogs, not how you should treat kernel
> > contributors.
> > 
> > Now, it is possible that Felipe just has problems with english, as he
> > called me piece of wood in https://lkml.org/lkml/2013/9/17/476 , but
> > he appears more arogant than usual over email.
> 
> Actually he called me "piece of wood with garbage in it". I guess I
> have right to be offended. I'm baby in the next email. Hmm.

what a baby. Grow up dude, just grow up. I said your commit log has
garbage which shouldn't be there (there was a typo you're instead of
your).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130918/d419425d/attachment.sig>
