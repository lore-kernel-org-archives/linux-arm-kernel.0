From: trblinux@gmail.com (Tushar Behera)
Date: Fri, 20 Feb 2015 08:57:39 +0530
Subject: [alsa-devel] [PATCH] ASoC: max98088: Add master clock handling
In-Reply-To: <1424373526-4135-1-git-send-email-afaerber@suse.de>
References: <1424283959-16289-3-git-send-email-afaerber@suse.de>
 <1424373526-4135-1-git-send-email-afaerber@suse.de>
Message-ID: <54E6A9AB.4070401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2015 12:48 AM, Andreas F?rber wrote:
> If master clock is provided through device tree, then update
> the master clock frequency during set_sysclk.
> 
> Cc: Tushar Behera <tushar.behera@linaro.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  sound/soc/codecs/max98088.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Looks good.

Acked-by: Tushar Behera <trblinux@gmail.com>

-- 
Tushar Behera
