From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 23 Dec 2013 21:57:54 +0300
Subject: [PATCH 2/2] ARM: shmobile: Lager: conditionally select
 CONFIG_MICREL_PHY
In-Reply-To: <20131223005322.GJ12239@verge.net.au>
References: <201312200218.08076.sergei.shtylyov@cogentembedded.com>
 <201312200220.54747.sergei.shtylyov@cogentembedded.com>
 <20131223005322.GJ12239@verge.net.au>
Message-ID: <52B887B2.7070507@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/23/2013 03:53 AM, Simon Horman wrote:

>> Now that support for KSZ8041RNLI is added to the Micrel PHY driver and we intend
>> to support PHY IRQs on the Lager board, we have to enable the Micrel driver.
>> Do this by selecting CONFIG_MICREL_PHY for Lager if CONFIG_SH_ETH is enabled.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Hi Sergei,

> while I am very happy to see this change unfortunately it no longer
> applies. Could you please rebase it on top of
> renesas-devel-v3.13-rc4-20131219?

    Hmm, it *was done* on top of this tag. Perhaps you meant today's 
renesas-devel-v3.13-rc5-20131223?

> Thanks

WBR, Sergei
