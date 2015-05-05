From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 05 May 2015 10:33:47 +0200
Subject: [PATCH v2 0/2] reset driver for NXP LPC18xx family
In-Reply-To: <1430779956-12490-1-git-send-email-manabian@gmail.com>
References: <1430779956-12490-1-git-send-email-manabian@gmail.com>
Message-ID: <1430814827.3035.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 05.05.2015, 00:52 +0200 schrieb Joachim Eastwood:
> This patch set adds a reset driver for NXP LPC18xx/43xx devices.
> 
> Changes in v2:
> * clean up header includes
> * prefix M0 reset defines with LPC43XX
> * fix comment about M0 reset lines
> * reorganize reset call chains
> * add reset number table to dt doc

I am satisfied with the changes.
I'd like a short patch description in both patches before applying them.

regards
Philipp
