From: dsd@laptop.org (Daniel Drake)
Date: Wed, 14 Aug 2013 13:22:03 -0600
Subject: [PATCH v6 06/11] clocksource: mmp: move mmp timer driver
In-Reply-To: <1374833133-21119-7-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-7-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CAMLZHHRhL6uG_V4vkB20ToXJdWtZ+iddVrm2HBf=W16pREWHug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 4:05 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Move timer-mmp driver from mach-mmp to clocksource directory.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Reviewed-by: Daniel Drake <dsd@laptop.org>

Maybe worth mentioning the underlying motivation in the commit message
- moving device drivers out of arch/arm?

Daniel
