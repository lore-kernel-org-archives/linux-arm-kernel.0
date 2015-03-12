From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 12 Mar 2015 12:08:47 -0700
Subject: Update the clk tree for linux-next
Message-ID: <CAPtuhTiQvSUMnd7p8D27GQ=hw1MqPSoN9P6pArLpK96QfnGsVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen R.,

Stephen Boyd has kindly agreed to co-maintain the clk framework with
me and we have shared commit access to a new git tree at kernel.org:

https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/

Can you update linux-next to pull from this tree instead of the
git.linaro.org address? They are currently mirrors but the
git.kernel.org tree is the canonical tree from this day forth. The
full path to pull from is:

git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next

This is already updated in MAINTAINERS.

Thanks,
Mike
