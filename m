From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 4 Nov 2015 14:00:18 -0800
Subject: [PATCH v2 1/2] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <563A5D0D.9030109@android.com>
References: <1446574204-15567-1-git-send-email-dcashman@android.com>
 <20151103160410.34bbebc805c17d2f41150a19@linux-foundation.org>
 <87k2pyppfk.fsf@x220.int.ebiederm.org>
 <20151103173156.9ca17f52.akpm@linux-foundation.org>
 <563A5D0D.9030109@android.com>
Message-ID: <20151104140018.2e0a00db747784046822a602@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Nov 2015 11:31:25 -0800 Daniel Cashman <dcashman@android.com> wrote:

> As for the
> clarification itself, where would you like it?  I could include a cover
> letter for this patch-set, elaborate more in the commit message itself,
> add more to the Kconfig help description, or some combination of the above.

In either [0/n] or [x/x] changelog, please.  I routinely move the [0/n]
material into the [1/n] changelog anyway.
