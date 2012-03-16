From: msalter@redhat.com (Mark Salter)
Date: Fri, 16 Mar 2012 10:40:06 -0400
Subject: [PATCH 05/38] Disintegrate asm/system.h for ARM [ver #3]
In-Reply-To: <20120315205603.28759.91855.stgit@warthog.procyon.org.uk>
References: <20120315205514.28759.58969.stgit@warthog.procyon.org.uk>
 <20120315205603.28759.91855.stgit@warthog.procyon.org.uk>
Message-ID: <1331908808.12353.2.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-03-15 at 20:56 +0000, David Howells wrote:
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-arm-kernel at lists.infradead.org
> ---

<snip>

> diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
> index 94e924e..d9072d9 100644
> --- a/include/linux/mtd/map.h
> +++ b/include/linux/mtd/map.h
> @@ -1,4 +1,4 @@
> -/*
> + r/*
>   * Copyright ? 2000-2010 David Woodhouse <dwmw2@infradead.org> et al.
>   *
>   * This program is free software; you can redistribute it and/or modify
> 

Looks like this hunk was unintended. It is causing a build failure for
me.

--Mark
