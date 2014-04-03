From: rabin@rab.in (Rabin Vincent)
Date: Fri, 4 Apr 2014 01:48:50 +0200
Subject: [PATCH] arm: don't allow CONFIG_DEBUG_SET_MODULE_RONX if
 CONFIG_JUMP_LABEL is enabled
In-Reply-To: <CAGXu5jKyzbRR4S0+0daygWcE2-BbFi1X6MFAkPqTNbGiT6huSQ@mail.gmail.com>
References: <1396346657-7166-1-git-send-email-holler@ahsoftware.de>
 <533AFF77.5030106@codeaurora.org>
 <CAGXu5jKMF9n9svQBhyQFvCoUe86QhLycDTt-fWyiRfySbn=Fug@mail.gmail.com>
 <CAH+eYFDkYczZXYF3be6tTRg7kkGhK2zyukDTo+N8mwEKcG89LA@mail.gmail.com>
 <CAGXu5jKyzbRR4S0+0daygWcE2-BbFi1X6MFAkPqTNbGiT6huSQ@mail.gmail.com>
Message-ID: <20140403234850.GA13956@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 04:14:54PM -0700, Kees Cook wrote:
> On Tue, Apr 1, 2014 at 4:08 PM, Rabin Vincent <rabin@rab.in> wrote:
> > Here's a patch (probably whitespace damaged, hence also attached) with
> > which dynamic ftrace works for me on top your other paches.  Tested on
> > a non-LPAE SMP.
> 
> Thanks! I'll incorporate calls to set_all_modules_text_rw/ro and see
> what I can make work.

You can use the patch I posted yesterday for module support:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244558.html
