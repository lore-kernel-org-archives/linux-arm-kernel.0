From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 14 Sep 2012 12:20:22 -0700
Subject: [PATCH] RTC: TWL: ensure all interrupts are disabled during probe
In-Reply-To: <CAOSpxdbGZFFShcS=_BZ78tAB3A5esPxY2WqNaGA9VXsBj8sP7g@mail.gmail.com>
References: <1347569157-19262-1-git-send-email-khilman@deeprootsystems.com>
 <CAOSpxdbGZFFShcS=_BZ78tAB3A5esPxY2WqNaGA9VXsBj8sP7g@mail.gmail.com>
Message-ID: <20120914122022.f56cd21d.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Sep 2012 08:33:42 -0700
Steve Sakoman <steve@sakoman.com> wrote:

> Tested-by: Steve Sakoman <steve@sakoman.com>

Thanks.

Given the tested-by's that are rolling in, I will assume that people
are hitting this problem in 3.5 and perhaps earlier kernels, so I
scheduled the fix for 3.6, with a -stable backport.

I might have been wrong about that - in future, please do make these
issues clear in the patch changelog?
