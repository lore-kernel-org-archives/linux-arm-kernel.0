From: dsd@laptop.org (Daniel Drake)
Date: Wed, 14 Aug 2013 13:37:45 -0600
Subject: [PATCH v6 07/11] ARM: mmp: move timer registers into driver
In-Reply-To: <1374833133-21119-8-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-8-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CAMLZHHQHkyFBan93kpDBNw==htC-VW0nCjv-TOBkkMWn0LFpyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 4:05 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Move the definition of timer registers into timer-mmp driver.
> And map timer registers in driver.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Reviewed-by: Daniel Drake <dsd@laptop.org>

Again, the commit message could better explain the "why". I guess this
is to reduce drivers/* independence on mach/ includes, which must be
eliminated for multiplatform build support.

Daniel
