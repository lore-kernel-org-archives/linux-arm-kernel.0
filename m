From: steve@sakoman.com (Steve Sakoman)
Date: Fri, 14 Sep 2012 12:44:54 -0700
Subject: [PATCH] RTC: TWL: ensure all interrupts are disabled during probe
In-Reply-To: <20120914122022.f56cd21d.akpm@linux-foundation.org>
References: <1347569157-19262-1-git-send-email-khilman@deeprootsystems.com>
 <CAOSpxdbGZFFShcS=_BZ78tAB3A5esPxY2WqNaGA9VXsBj8sP7g@mail.gmail.com>
 <20120914122022.f56cd21d.akpm@linux-foundation.org>
Message-ID: <CAOSpxdYDbPZXtkdzpyUXN8j1rAvph=VQZCkFfiDA2jN4E=oFBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 12:20 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:

> Given the tested-by's that are rolling in, I will assume that people
> are hitting this problem in 3.5 and perhaps earlier kernels, so I
> scheduled the fix for 3.6, with a -stable backport.

Yes, I just checked an Overo setup here that is running 3.2 and it has
the same issue.

So your plan for 3.6 and -stable is a good one.

Steve
