From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 1 Jul 2010 15:26:43 -0700
Subject: [PATCH 1/3] FB: Add some members for CPU Interface.
In-Reply-To: <4C29CABE.9020208@samsung.com>
References: <4C29AF72.6090200@samsung.com> <4C29B1C1.2000209@samsung.com>
	<4C29CABE.9020208@samsung.com>
Message-ID: <20100701152643.41834b17.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Jun 2010 19:28:14 +0900
InKi Dae <inki.dae@samsung.com> wrote:

> 
> CPU interface needs cs, wr setup, wr act and hold delay.
> I added some members for them to common framework.
> 
> Signed-off-by: InKi Dae <inki.dae at samsung.com <mailto:p.osciak@samsung.com>>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com
> <mailto:kyungmin.park@samsung.com>>

These email addresses are mangled.

> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> ...
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h

The patch seems pretty specific to s3c-fb.  Is it possible and sensible
to somhow avoid adding code to generic files?  Can we push more (or
all) of these changes into s3c-fb.c or into the arch/arm support code?
