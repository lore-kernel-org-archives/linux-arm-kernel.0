From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Sep 2016 11:46:52 +0100
Subject: next-20160906 build: 2 failures 0 warnings (next-20160906)
In-Reply-To: <E1bhC0l-0003y3-Ls@optimist>
References: <E1bhC0l-0003y3-Ls@optimist>
Message-ID: <20160906104652.GJ3950@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 09:45:43AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build arm and arm64 defconfigs due to:

> 	arm64-allmodconfig
> ../drivers/pwm/pwm-berlin.c:245:35: error: 'struct berlin_pwm_chip' has no member named 'chips'

> 	arm-allmodconfig
> ../drivers/pwm/pwm-berlin.c:245:35: error: 'struct berlin_pwm_chip' has no member named 'chips'

due to fd47f104003c6 (pwm: berlin: Add suspend/resume support) which was
applied yesterday.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/b88ca046/attachment.sig>
