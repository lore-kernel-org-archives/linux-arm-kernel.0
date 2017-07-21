From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri, 21 Jul 2017 11:25:50 +0200
Subject: USB PHY reset for Nitrogen6x/MAX
Message-ID: <CAAMH-ytNeNc=XOOoEOztL_6Y4jcHHyQ+12pFTaNN-1MQ9kQjFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn, Fabio,

Last October I offered the following two patches that add regulators
to fix USB PHY reset on 2 of our boards:
https://patchwork.kernel.org/patch/9395531/
https://patchwork.kernel.org/patch/9395539/

At the time you preferred to wait for Peter's pwrseq sub-system to get
in to have a proper reset sequence.

Since then, it seems that it's still going to take a long time before
Peter's series makes it to mainline and many customers of ours
complained about USB.

Would you consider adding back those two patches for next cycle. We
can still modify them to use pwrseq in the future.

Regards,
Gary
