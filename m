From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 26 Apr 2015 16:31:30 +0200 (CEST)
Subject: Question about DC-DC frequency handling
Message-ID: <604104768.496325.1430058690855.JavaMail.open-xchange@oxbaltgw00.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

i'm current working on a regulator driver which should be able to change DC-DC
clock frequency.

Now here is my question. What is the prefered way to implement the clock
handling?

Option A):

The regulator driver handles all internally (select clock source, set
frequency).

Option B):

The DC-DC clock domain is implemented in the clock driver and the regulator
driver uses the clock framework.

Best regards
Stefan
