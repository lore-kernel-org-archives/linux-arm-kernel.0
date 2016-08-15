From: davem@davemloft.net (David Miller)
Date: Mon, 15 Aug 2016 16:35:03 -0700 (PDT)
Subject: [PATCH -next] net: thunderx: Remove unnecessary pci_set_drvdata()
In-Reply-To: <1471301489-24888-1-git-send-email-weiyj.lk@gmail.com>
References: <1471301489-24888-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160815.163503.1779445142068275986.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Mon, 15 Aug 2016 22:51:29 +0000

> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Applied.
