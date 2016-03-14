From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 14 Mar 2016 17:52:06 +0100
Subject: Regression in next caused by 95026658c46e i2c: do not use
 internal..
In-Reply-To: <20160314160944.GG9329@atomide.com>
References: <20160314160944.GG9329@atomide.com>
Message-ID: <20160314165206.GA16371@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Having something like this happen just as the merge window opens is
> not nice. You guys should already know..

I already applied the fix.

> The patches in next should be sitting there for a few weeks before the
> merge window so issues like this are found out early.

I understand this was a major hickup and I am sorry for this. I should
have known better.

I am not taking 100% of the blame, though: The amount of submissions is
rising faster than the amount of non-maintainer review being done (at
least in the subsystems I work on). I took a wrong step in trying to
handle the gap. I am really sorry about the fuzz, yet I can't deny there
is also something inevitable in that to me. That being said, I'll of
course try harder to not let this happen again.

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160314/4f3c058b/attachment.sig>
