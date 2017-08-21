From: davem@davemloft.net (David Miller)
Date: Mon, 21 Aug 2017 13:55:04 -0700 (PDT)
Subject: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
In-Reply-To: <20170822001928.74f01322@roar.ozlabs.ibm.com>
References: <20170821160605.5b1cc019@roar.ozlabs.ibm.com>
 <20170821111833.00006753@huawei.com>
 <20170822001928.74f01322@roar.ozlabs.ibm.com>
Message-ID: <20170821.135504.1392954698746959868.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 22 Aug 2017 00:19:28 +1000

> Thanks here's an updated version with a couple more bugs fixed. If
> you could try testing, that would be much appreciated.

I'm not getting RCU stalls on sparc64 any longer with this patch.

I'm really happy you guys were able to figure out what was going
wrong. :-)

Feel free to add my Tested-by:
