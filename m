From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Fri, 26 Apr 2013 11:27:05 -0700
Subject: [PATCH V3] ARM: KVM: Allow host virtual timer irq number to be
 different from guest virtual timer irq number
In-Reply-To: <CAAhSdy3XVRVp62xeuPp6Dum1OwvgmF1UKqwTqABUp71WS7ronw@mail.gmail.com>
References: <1366982847-11028-1-git-send-email-anup.patel@linaro.org>
 <517A8560.6070005@arm.com>
 <CAAhSdy3XVRVp62xeuPp6Dum1OwvgmF1UKqwTqABUp71WS7ronw@mail.gmail.com>
Message-ID: <CAEDV+g+a7zVnGBKJT9c+B_tiO8PEy-J2CQBWOxznMMrY1bDSOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Sure, I incorporate all above comments and send revised patch.
>
Hi Anup,

Now when we're at it, your commit message is exessively long, both the
title and the actual content. Please try to keep the commit message
under 80 chars at least and the title of the patch even shorter if
possible: think doing a 'git log' on an 80 char terminal...

-Christoffer
