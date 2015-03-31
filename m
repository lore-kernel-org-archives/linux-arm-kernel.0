From: davem@davemloft.net (David Miller)
Date: Tue, 31 Mar 2015 16:52:16 -0400 (EDT)
Subject: [PATCH v2 0/8] net/macb: fixes after big driver update
In-Reply-To: <1427806926-18887-1-git-send-email-nicolas.ferre@atmel.com>
References: <1427806926-18887-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150331.165216.1751909468171592817.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Tue, 31 Mar 2015 15:01:58 +0200

> The recent modifications to the macb driver lead to issues with the probe
> function code flow. Here are some attempt to fix them.
> This time, some more issues are fixed related to the clock as reported by Boris
> Brezillon.
> 
> The series is written on top of net-next.
> 
> Changes in v2:
> - address Cyrille comment about exit condition of queue configuration loop
> - add fixes for probe sequence related to clocks
> - add ethtool register dump
> - fix peripheral version test

Series applied, thanks.
