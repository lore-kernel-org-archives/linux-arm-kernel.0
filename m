From: me@tobin.cc (Tobin C. Harding)
Date: Thu, 25 May 2017 09:28:18 +1000
Subject: [PATCH] Staging: bcm2835-audio: bcm2835-ctl.c: Fixed a comment
 coding style issue.
In-Reply-To: <1495636394-2431-1-git-send-email-srishtishar@gmail.com>
References: <1495636394-2431-1-git-send-email-srishtishar@gmail.com>
Message-ID: <20170524232818.GF2319@eros>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 08:03:14PM +0530, srishti sharma wrote:

This driver is not in Greg KH's staging tree. You may like to work off
of that tree when doing staging patches.

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/

To aid you future patches here are a couple of minor comments for you.

> fixed a trailing */ issue

You may like to be more explicit here using the format described in
Documentation/process/submitting-patches.rst (Section 2 Describe your
changes). This goes for your subject line as well.

> Signed-off-by: srishti sharma <srishtishar@gmail.com>
> ---
>  drivers/staging/bcm2835-audio/bcm2835-ctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/bcm2835-audio/bcm2835-ctl.c
> index a4ffa1b..38fabab 100644
> --- a/drivers/staging/bcm2835-audio/bcm2835-ctl.c
> +++ b/drivers/staging/bcm2835-audio/bcm2835-ctl.c
> @@ -247,8 +247,8 @@ static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
>  	struct snd_ctl_elem_value *ucontrol)
>  {
>  	/* bcm2835 supports only consumer mode and sets all other format flags
> -	 * automatically. So the only thing left is signalling non-audio
> -	 * content */
> +	 * automatically. So the only thing left is signalling non-audio content
> +	 */

And for completeness this is the block comment style in networking
code, the rest of the kernel uses the format

/*
 * block comment blah blah
 * on multiple lines
 */

Good luck,
Tobin.
