From: davem@davemloft.net (David Miller)
Date: Tue, 25 Aug 2009 20:39:55 -0700 (PDT)
Subject: [PATCH 2/2] irda/sa1100_ir: fix broken netdev_ops conversion
In-Reply-To: <1251125760-6547-1-git-send-email-a.beregalov@gmail.com>
References: <1251125760-6547-1-git-send-email-a.beregalov@gmail.com>
Message-ID: <20090825.203955.125407912.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Mon, 24 Aug 2009 18:56:00 +0400

> This patch is based on commit d2f3ad4 (pxaficp-ir: remove incorrect
> net_device_ops). Do the same for sa1100_ir.
> Untested.
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>

Applied.
