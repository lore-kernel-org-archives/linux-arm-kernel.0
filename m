From: davem@davemloft.net (David Miller)
Date: Thu, 01 Aug 2013 14:31:37 -0700 (PDT)
Subject: [PATCH V2 3/3] ethernet: Convert mac address uses of 6 to ETH_ALEN
In-Reply-To: <CAOesGMhf-2KE1B8_4CGJADCG=ceDFRrDbhTnA56kXYPWoKTScg@mail.gmail.com>
References: <20130801210618.GK23006@n2100.arm.linux.org.uk>
 <20130801.141016.1475274289112004539.davem@davemloft.net>
 <CAOesGMhf-2KE1B8_4CGJADCG=ceDFRrDbhTnA56kXYPWoKTScg@mail.gmail.com>
Message-ID: <20130801.143137.331385226409040561.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olof@lixom.net>
Date: Thu, 1 Aug 2013 14:24:32 -0700

> So, you might as well leave the code alone for now. It's not used on
> fast path, and the system definitely handles unaligned accesses for
> this -- it has for years already.

Fair enough, Joe please respin.
