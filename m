From: davem@davemloft.net (David Miller)
Date: Wed, 11 Jan 2017 16:12:51 -0500 (EST)
Subject: [PATCH net-next] net: thunderx: Fix error return code in
 nicvf_open()
In-Reply-To: <20170111163251.19367-1-weiyj.lk@gmail.com>
References: <20170111163251.19367-1-weiyj.lk@gmail.com>
Message-ID: <20170111.161251.1979714688980792559.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Wed, 11 Jan 2017 16:32:51 +0000

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 712c31853440 ("net: thunderx: Program LMAC credits based on MTU")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied.
