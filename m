From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 15 Oct 2009 20:53:20 +0400
Subject: [RESEND][PATCH] mtd: maps: remove obsolete ipaq-flash driver
In-Reply-To: <1255433694-26471-1-git-send-email-mad_soft@inbox.ru>
References: <1255433694-26471-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <20091015165320.GA24086@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 03:34:54PM +0400, Dmitry Artamonow wrote:
> This driver seems to be obsolete and broken for a long time.
> It depends on CONFIG_IPAQ_HANDHELD that simply doesn't exists
> anywhere in kernel. Also, it seems that none of machines it
> claims to support have any use of it:
>  SA11xx-based iPAQs (h3100/h3600) use sa1100-flash
>  iPAQ h5000 uses physmap-flash
>  Jornada 720 uses sa1100-flash
>  Jornada 560 and iPAQ h1910 are not in mainline
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
