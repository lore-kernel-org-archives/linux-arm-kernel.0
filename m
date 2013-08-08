From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 8 Aug 2013 10:13:27 -0700
Subject: [PATCH v6 13/20] pwm: Add new pwm-samsung driver
In-Reply-To: <4144776.HcbubHMX0J@flatron>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374623475.SoL01ZHzWk@flatron>
 <CAL1qeaF1Mxs_Q6QnLznW3SoXBoNhBb+gCYMESMgx6g+bUFVCmQ@mail.gmail.com>
 <4144776.HcbubHMX0J@flatron>
Message-ID: <CAL1qeaH=r0Yr-8gqy+QctvaM_1awT1aHjT_HjXA71sjpK4BJHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ..it should not be defined as non-static in this case (= an ifdef is
> needed in this header). I believe I had this already fixed, not sure what
> happened with the fix...

Perhaps this is it: https://patchwork.kernel.org/patch/2787271/.  That
should probably land with this patchset too.

Thanks,
Andrew
