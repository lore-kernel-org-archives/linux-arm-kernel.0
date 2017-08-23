From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 23 Aug 2017 21:33:26 +0200
Subject: [PATCH 06/11] ASoC: pxa: make snd_soc_platform_driver const
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-7-git-send-email-bhumirks@gmail.com>
Message-ID: <87wp5uoz95.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bhumika Goyal <bhumirks@gmail.com> writes:

> Make these const as they are only passed as the 2nd argument to the
> function devm_snd_soc_register_platform, which is of type const.
> Done using Coccinelle.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  sound/soc/pxa/mmp-pcm.c    | 2 +-
>  sound/soc/pxa/pxa2xx-pcm.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

For sound/soc/pxa/pxa2xx-pcm.c :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
