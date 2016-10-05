From: muhammadabdul.wahab@centralesupelec.fr (Muhammad Abdul WAHAB)
Date: Wed, 5 Oct 2016 12:23:18 +0200
Subject: [PATCH] Adding missing features of Coresight PTM components
In-Reply-To: <CANLsYkybp0Lm-WStT=__yyug1Z9hFG7dgCp8E=iL5_x9C1vv-w@mail.gmail.com>
References: <583ccfa4-ee4e-561a-5480-d0f243194ee3@supelec.fr>
 <CANLsYkybp0Lm-WStT=__yyug1Z9hFG7dgCp8E=iL5_x9C1vv-w@mail.gmail.com>
Message-ID: <e4115ffb-5fcb-4322-7270-b0ca87065880@centralesupelec.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

> The rule of thumb when writing a patch description is to specify "why"
> rather than "what" you are doing.  The above describe the why alright
> and should be kept.  Everything below until your SOB describe what you
> are doing and should be removed.

I modified the patch according to your remarks and will submit it.

 > There is indeed an indentation problem here but it can't be fixed in
 > this patch.  Please do another patch for this.

I created another patch for it.

 > The sysFS mode users can do what they want, including configurations
 > not supported by the HW.  There are so many rules and exception that
 > adding a check for every one of they doesn't scale up.  I suggest to
 > remove the above check.

This check was removed. The return stack feature is not available in ETM 
and the corresponding bit is reserved and should be zero. That's why an 
additional check was made.

 > You patch doesn't apply on my tree.  Please use "git format-patch" for
 > your next submission.  Last but not least the email address in the
 > "from:" part of the submission doesn't match the one in the SOB - they
 > have to be similar.

All the above suggestions were made and will be submitted in the 2nd 
version of the patch.

Thank you,
M.Abdul WAHAB
