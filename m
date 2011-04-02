From: davem@davemloft.net (David Miller)
Date: Sat, 02 Apr 2011 00:57:14 -0700 (PDT)
Subject: [PATCH 1/1] net/fec: do not pass NULL dev to DMA API
In-Reply-To: <1301726391-7431-1-git-send-email-b29396@freescale.com>
References: <1301726391-7431-1-git-send-email-b29396@freescale.com>
Message-ID: <20110402.005714.258110130.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


First, your patches never make it to the mailing list because the list
server rejects your postings, due to the fact that there are syntax
errors in your email headers:

Illegal-Object:	Syntax error in From: address found on vger.kernel.org:
	From:	Aisheng.Dong<b29396@freescale.com>
				    ^-missing end of mailbox

Second, this patch does not apply to the current tree at all.
This bug has already been fixed and there are no cases where
a NULL device is passed to the DMA API interfaces any more.
