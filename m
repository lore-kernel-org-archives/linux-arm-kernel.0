From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Sep 2013 11:36:49 -0500
Subject: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
In-Reply-To: <201309181756.12782@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <20130918133025.GB2953@amd.pavel.ucw.cz>
 <CAAwP0s0nGthkm9Bp1ug23Rtz6-sbR60FFTSfd-Cj9wKMU0RBEA@mail.gmail.com>
 <201309181756.12782@pali>
Message-ID: <20130918163649.GL21559@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 05:56:12PM +0200, Pali Roh?r wrote:
> On Wednesday 18 September 2013 15:57:13 Javier Martinez Canillas 
> wrote:
> > to split the patch in two since the patch was solving
> > two separate issues
> 
> My patch does not solving *two* issues. It is *one* regression 
> and both parts of patch are needed for fixing it. Read commit 
> message again. It does not make sense to split patch fixing kernel 
> regression into more one line patches - or please clarify why.

issue 1) twl4030-usb.c doesn't initialize atomic notifier head
issue 2) musb doesn't call notifier chain

do you need a drawing ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130918/09be804b/attachment.sig>
