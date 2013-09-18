From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Sep 2013 11:21:46 -0700
Subject: [PATCH v2 2/2] RX-51: ARM errata 430973 workaround
In-Reply-To: <201309182013.52975@pali>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
 <201309181033.24965@pali> <20130918171816.GT9994@atomide.com>
 <201309182013.52975@pali>
Message-ID: <20130918182144.GY9994@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [130918 11:21]:
> On Wednesday 18 September 2013 19:18:17 Tony Lindgren wrote:
> > 
> > Hmm hasn't there been pending comments until recently on your
> > patches?
> > 
> 
> Since 10.07.2013 I do not have any emails for patch 2/2. If I 
> missed something from you, please resend me it.

Sorry I noticed it only when looking at them again from "keep
in my inbox for applying" or "mark as read and archive" point
of view. So no other comments from me are pending.
 
> > It seems that with the changes I suggested your patches should
> > work for both legacy booting and DT based booting, so maybe
> > just try to update them over next few weeks, let's say by
> > -rc3 rather than wait 2 to 5 months? :) No need to test them
> > currently on the DT based booting if you don't have that set
> > up, just move the code out of the board-*.c file.
> > 
> 
> Ok, no problem. I will move code as you suggested.

Thanks,

Tony
