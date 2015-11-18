From: keescook@chromium.org (Kees Cook)
Date: Wed, 18 Nov 2015 15:26:33 -0800
Subject: [PATCH 1/4] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <564D088E.7060409@android.com>
References: <1447886901-26098-1-git-send-email-dcashman@android.com>
 <1447886901-26098-2-git-send-email-dcashman@android.com>
 <CAGXu5jL7GXKqj1UTpwEwtZ_kKpeorA0fz84Pq=15kdZ3vGytQA@mail.gmail.com>
 <564D088E.7060409@android.com>
Message-ID: <CAGXu5j+7ShmxMmAG-DFrtL4PpXg8Nboh53ZFVZmcYzBg2kEVFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 3:23 PM, Daniel Cashman <dcashman@android.com> wrote:
>> I think the min/max values should be const, since they're determined
>> at build time and should never change.
>
> Ok. Also, I just submitted the patch-set again with [PATCH v3] instead
> of [PATCH] so I'd prefer discussion there; sorry for the mistake.

Oops, yeah, just saw that come in after I already sent my comments. :P

-Kees

-- 
Kees Cook
Chrome OS Security
