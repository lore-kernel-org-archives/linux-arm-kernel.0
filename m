From: eric@anholt.net (Eric Anholt)
Date: Wed, 17 Jan 2018 11:47:58 -0800
Subject: [PATCH -next] hwrng: bcm2835 - Remove redundant dev_err call in
 bcm2835_rng_probe()
In-Reply-To: <1516189234-11957-1-git-send-email-weiyongjun1@huawei.com>
References: <1516189234-11957-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <876080mfm9.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wei Yongjun <weiyongjun1@huawei.com> writes:

> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180117/5bab1230/attachment.sig>
