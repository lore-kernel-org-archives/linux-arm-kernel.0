From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 12 Oct 2017 19:29:02 +0200 (CEST)
Subject: [PATCH 08/20] staging: vc04_services: vchiq_core: mark expected
 switch fall-through
In-Reply-To: <f7666b46f3a50ba58eac5454680bbba4d84fe6c2.1507781178.git.garsilva@embeddedor.com>
References: <cover.1507781178.git.garsilva@embeddedor.com>
 <f7666b46f3a50ba58eac5454680bbba4d84fe6c2.1507781178.git.garsilva@embeddedor.com>
Message-ID: <9079364.189932.1507829342222@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> "Gustavo A. R. Silva" <garsilva@embeddedor.com> hat am 12. Oktober 2017 um 18:16 geschrieben:
> 
> 
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
