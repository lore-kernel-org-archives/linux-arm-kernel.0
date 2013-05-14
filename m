From: davem@davemloft.net (David Miller)
Date: Tue, 14 May 2013 13:04:50 -0700 (PDT)
Subject: [PATCH v2] net/macb: fix ISR clear-on-write behavior only for
 some SoC
In-Reply-To: <20130514162450.GF22508@game.jcrosoft.org>
References: <1368461105-23128-1-git-send-email-nicolas.ferre@atmel.com>
 <1368536416-18364-1-git-send-email-nicolas.ferre@atmel.com>
 <20130514162450.GF22508@game.jcrosoft.org>
Message-ID: <20130514.130450.144239429801008287.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 14 May 2013 18:24:50 +0200

> On 15:00 Tue 14 May     , Nicolas Ferre wrote:
>> Commit 749a2b6 (net/macb: clear tx/rx completion flags in ISR)
>> introduces clear-on-write on ISR register. This behavior is not always
>> implemented when using Cadence MACB/GEM and is breaking other platforms.
>> We are using the Design Configuration Register 1 information and a capability
>> property to actually activate this clear-on-write behavior on ISR.
>> 
>> Reported-by: Hein Tibosch <hein_tibosch@yahoo.es>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Applied, thanks.
