From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 1 Feb 2013 15:47:47 -0800
Subject: [rtc-linux] [PATCH] rtc: pl031: fix the missing operation on
 enable
In-Reply-To: <CAD6h2NS6dGYBvbwQ2u4FvQZ_uW8wUcT+cSA14xRzUyDfLwyQCg@mail.gmail.com>
References: <1359507865-29808-1-git-send-email-haojian.zhuang@linaro.org>
 <20130131144459.39f9a978.akpm@linux-foundation.org>
 <CAD6h2NS6dGYBvbwQ2u4FvQZ_uW8wUcT+cSA14xRzUyDfLwyQCg@mail.gmail.com>
Message-ID: <20130201154747.76a8a63b.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Feb 2013 09:32:59 +0800
Haojian Zhuang <haojian.zhuang@linaro.org> wrote:

> Without this
> patch, I really
> failed to enable RTC in Hisilicon Hi3620 SoC. It results that the
> register mapping section
> in RTC is always read as zero. So I doubt that ST guys may already
> enable this register
> in bootloader. So they won't meet this issue.

OK, thanks, that sounds pretty serious so I tagged the patch for
backporting into -stable kernels as well.
