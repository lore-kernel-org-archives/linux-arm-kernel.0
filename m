From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 13 Jun 2017 15:00:06 +0200
Subject: [PATCH] Staging: vc04_services: bcm2835-audio: bcm2835-ctl.c:
 Fixed alignment to match open parenthesis.
In-Reply-To: <1497042442-3620-1-git-send-email-srishtishar@gmail.com>
References: <1497042442-3620-1-git-send-email-srishtishar@gmail.com>
Message-ID: <20170613130006.GA15978@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 10, 2017 at 02:37:22AM +0530, srishti sharma wrote:
> Fixed alignment so that it matched open parenthesis.
> 
> Signed-off-by: srishti sharma <srishtishar@gmail.com>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> index f484bb0..2148ed0 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> @@ -105,7 +105,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
>  }
> 
>  static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,
> -				struct snd_ctl_elem_value *ucontrol)
> +			       struct snd_ctl_elem_value *ucontrol)
>  {
> 	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
> 	int changed = 0;

This patch is corrupted and can not be applied :(
