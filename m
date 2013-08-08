From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 08 Aug 2013 14:27:07 -0700 (PDT)
Subject: [PATCH v6 13/20] pwm: Add new pwm-samsung driver
In-Reply-To: <CAL1qeaH=r0Yr-8gqy+QctvaM_1awT1aHjT_HjXA71sjpK4BJHg@mail.gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <4144776.HcbubHMX0J@flatron>
 <CAL1qeaH=r0Yr-8gqy+QctvaM_1awT1aHjT_HjXA71sjpK4BJHg@mail.gmail.com>
Message-ID: <1914245.MWaKtJIXGf@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 of August 2013 10:13:27 Andrew Bresticker wrote:
> > ..it should not be defined as non-static in this case (= an ifdef is
> > needed in this header). I believe I had this already fixed, not sure
> > what happened with the fix...
> 
> Perhaps this is it: https://patchwork.kernel.org/patch/2787271/.  That
> should probably land with this patchset too.

Oh yes, this is it.

I know what happened now. This series was already queued for 3.11 in 
Samsung tree. After a bit of testing in linux-next Bart found the build 
error and sent a fix, which was going to be merged for 3.11 as well. 
However since there have been some problems just before merge window 
started, this series had to be dropped, including the fixup patch.

Thanks for reporting. Let me try to sort this out.

Best regards,
Tomasz
