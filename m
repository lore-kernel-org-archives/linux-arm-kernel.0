From: davem@davemloft.net (David Miller)
Date: Mon, 16 Jan 2017 20:13:25 -0500 (EST)
Subject: [PATCH v2 net-next 0/2] mvneta xmit_more and bql support
In-Reply-To: <1484586512-16412-1-git-send-email-mw@semihalf.com>
References: <1484586512-16412-1-git-send-email-mw@semihalf.com>
Message-ID: <20170116.201325.2191165766691361664.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>
Date: Mon, 16 Jan 2017 18:08:30 +0100

> This is a delayed v2 of short patchset, which introduces xmit_more and BQL
> to mvneta driver. The only one change was added in xmit_more support -
> condition check preventing excessive descriptors concatenation before
> flushing in HW.
> 
> Any comments or feedback would be welcome.
 ...
> Changelog:
> v1 -> v2:
> 
> * Add checking condition that ensures too much descriptors are not
>   concatenated before flushing in HW.

Looks good, series applied, thanks.
