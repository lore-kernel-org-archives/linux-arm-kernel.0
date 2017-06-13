From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Jun 2017 21:35:27 +0100
Subject: [PATCH v6 5/8] regulator: hi6421v530: add driver for hi6421v530
 voltage regulator
In-Reply-To: <20170608220841.26531-6-guodong.xu@linaro.org>
References: <20170608220841.26531-1-guodong.xu@linaro.org>
 <20170608220841.26531-6-guodong.xu@linaro.org>
Message-ID: <20170613203527.ecykjzzpvkrzl7zz@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 06:08:38AM +0800, Guodong Xu wrote:
> From: Wang Xiaoyin <hw.wangxiaoyin@hisilicon.com>
> 
> add the driver for hi6421v530 voltage regulator

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/f88b3ca0/attachment.sig>
