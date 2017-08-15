From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Tue, 15 Aug 2017 09:05:55 +0300
Subject: [PATCH 05/11] ASoC: omap: make snd_soc_platform_driver const
In-Reply-To: <1502710730-18912-6-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-6-git-send-email-bhumirks@gmail.com>
Message-ID: <20170815060555.GA3824@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 05:08:44PM +0530, Bhumika Goyal wrote:
> Make this const as it is only passed as the 2nd argument to the
> function devm_snd_soc_register_platform, which is of type const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  sound/soc/omap/omap-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
