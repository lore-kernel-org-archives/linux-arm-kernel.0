From: davem@davemloft.net (David Miller)
Date: Fri, 31 Aug 2012 15:49:31 -0400 (EDT)
Subject: [PATCH v2] cs89x0 : packet reception not working
In-Reply-To: <1346104431-3784-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1346104431-3784-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <20120831.154931.1463711821590835826.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
Date: Mon, 27 Aug 2012 23:53:51 +0200

> The RxCFG register of the CS89x0 could be configured incorrectly
> (because of misplaced parentheses), resulting in the disabling
> of packet reception.
> 
> Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>

Applied and queued up for -stable, thanks.
