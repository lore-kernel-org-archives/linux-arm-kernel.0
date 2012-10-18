From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Oct 2012 16:27:57 -0600
Subject: [PATCH 05/10] i2c: pxa: use devm_kzalloc
In-Reply-To: <1350551224-12857-5-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-5-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <5080826D.6040108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 03:06 AM, Haojian Zhuang wrote:
> Use devm_kzalloc & add checking in probe() function.

This patch seems unrelated to this series. In fact, the series touches a
bunch of different subsystems; would you expect all these patches to be
merged through a single tree? If so, which?
