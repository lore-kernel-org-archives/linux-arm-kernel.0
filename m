From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 12 Jun 2014 11:55:09 +0200
Subject: [PATCH v2 03/10] DMA,
 CMA: separate core cma management codes from DMA APIs
In-Reply-To: <1402543307-29800-4-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-4-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <xa1tbntyjvuq.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12 2014, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> To prepare future generalization work on cma area management code,
> we need to separate core cma management codes from DMA APIs.
> We will extend these core functions to cover requirements of
> ppc kvm's cma area management functionality in following patches.
> This separation helps us not to touch DMA APIs while extending
> core functions.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>


-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
