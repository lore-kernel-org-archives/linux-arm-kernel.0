From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 19 Oct 2012 09:16:59 +0800
Subject: [PATCH 05/10] i2c: pxa: use devm_kzalloc
In-Reply-To: <5080826D.6040108@wwwdotorg.org>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-5-git-send-email-haojian.zhuang@gmail.com>
 <5080826D.6040108@wwwdotorg.org>
Message-ID: <CAN1soZw-r2Jb=dRfinNJBB1_yo1zuQD9AEF-F-qchSboFd1WNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 6:27 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 10/18/2012 03:06 AM, Haojian Zhuang wrote:
>> Use devm_kzalloc & add checking in probe() function.
>
> This patch seems unrelated to this series. In fact, the series touches a
> bunch of different subsystems; would you expect all these patches to be
> merged through a single tree? If so, which?

Yes, I expect all these patches could be merged by pinctrl subtree.

Regards
Haojian
