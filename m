From: dcashman@android.com (Daniel Cashman)
Date: Wed, 18 Nov 2015 15:23:58 -0800
Subject: [PATCH 1/4] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <CAGXu5jL7GXKqj1UTpwEwtZ_kKpeorA0fz84Pq=15kdZ3vGytQA@mail.gmail.com>
References: <1447886901-26098-1-git-send-email-dcashman@android.com>
 <1447886901-26098-2-git-send-email-dcashman@android.com>
 <CAGXu5jL7GXKqj1UTpwEwtZ_kKpeorA0fz84Pq=15kdZ3vGytQA@mail.gmail.com>
Message-ID: <564D088E.7060409@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think the min/max values should be const, since they're determined
> at build time and should never change.

Ok. Also, I just submitted the patch-set again with [PATCH v3] instead
of [PATCH] so I'd prefer discussion there; sorry for the mistake.

-Dan
