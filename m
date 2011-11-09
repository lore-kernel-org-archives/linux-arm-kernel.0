From: paul.s.schilling@gmail.com (Paul Schilling)
Date: Wed, 9 Nov 2011 17:30:59 -0600
Subject: s3c2440 / s3c2416 broken
In-Reply-To: <CAC=G6syKMJk+L+-_k+T37qHKzfpNz_TrYi-HTaufczLxJKEtkQ@mail.gmail.com>
References: <CAC=G6syKMJk+L+-_k+T37qHKzfpNz_TrYi-HTaufczLxJKEtkQ@mail.gmail.com>
Message-ID: <CAC=G6swbDHZJ7fqu9LoYRiri6bg+M+VDZnG_-=ZfP9r=6YtVeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boot past init slow - stalled when using jffs2 also.

On Wed, Nov 9, 2011 at 4:12 PM, Paul Schilling
<paul.s.schilling@gmail.com> wrote:
> Latest kernel 3.2.0-rc1 appears to break the following processors
> s3c2440 and s3c2416
>
> both appear to stall when init is executed on NFS. ?Also I ?lost HSMMC on
> the s3c2416.
>
> Thanks,
> Paul
>
