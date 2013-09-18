From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Sep 2013 11:48:17 -0500
Subject: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
In-Reply-To: <201309181843.49850@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309181756.12782@pali> <20130918163649.GL21559@radagast>
 <201309181843.49850@pali>
Message-ID: <20130918164816.GN21559@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 06:43:49PM +0200, Pali Roh?r wrote:
> On Wednesday 18 September 2013 18:36:49 Felipe Balbi wrote:
> > On Wed, Sep 18, 2013 at 05:56:12PM +0200, Pali Roh?r wrote:
> > > On Wednesday 18 September 2013 15:57:13 Javier Martinez
> > > Canillas
> > > 
> > > wrote:
> > > > to split the patch in two since the patch was solving
> > > > two separate issues
> > > 
> > > My patch does not solving *two* issues. It is *one*
> > > regression and both parts of patch are needed for fixing
> > > it. Read commit message again. It does not make sense to
> > > split patch fixing kernel regression into more one line
> > > patches - or please clarify why.
> > 
> > issue 1) twl4030-usb.c doesn't initialize atomic notifier head
> > issue 2) musb doesn't call notifier chain
> > 
> > do you need a drawing ?
> 
> Regression 1) power supply drivers not working since v3.5
> 
> Look at firsts emails.
> 
> 
> Do you really have problem to do what *you* need with 1 line 
> patch which I sent? Or what what you want?

if you had already resent patches the way I requested, they'd already be
applied. Instead you chose to troll the people who are trying to helping
out.

You have two issues being fixed in the same patch and that's not
acceptable.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130918/68a1dfef/attachment-0001.sig>
