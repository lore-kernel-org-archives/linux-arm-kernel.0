From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 18 Sep 2013 18:43:49 +0200
Subject: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
In-Reply-To: <20130918163649.GL21559@radagast>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309181756.12782@pali> <20130918163649.GL21559@radagast>
Message-ID: <201309181843.49850@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 September 2013 18:36:49 Felipe Balbi wrote:
> On Wed, Sep 18, 2013 at 05:56:12PM +0200, Pali Roh?r wrote:
> > On Wednesday 18 September 2013 15:57:13 Javier Martinez
> > Canillas
> > 
> > wrote:
> > > to split the patch in two since the patch was solving
> > > two separate issues
> > 
> > My patch does not solving *two* issues. It is *one*
> > regression and both parts of patch are needed for fixing
> > it. Read commit message again. It does not make sense to
> > split patch fixing kernel regression into more one line
> > patches - or please clarify why.
> 
> issue 1) twl4030-usb.c doesn't initialize atomic notifier head
> issue 2) musb doesn't call notifier chain
> 
> do you need a drawing ?

Regression 1) power supply drivers not working since v3.5

Look at firsts emails.


Do you really have problem to do what *you* need with 1 line 
patch which I sent? Or what what you want?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130918/7f96b2a0/attachment.sig>
