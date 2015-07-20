From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 10:04:59 +0200
Subject: [RFC PATCH 06/15] pwm: define a new pwm_state struct
In-Reply-To: <1435738921-25027-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150720080458.GG29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 10:21:52AM +0200, Boris Brezillon wrote:
[...]
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
[...]
> +struct pwm_state {
> +	unsigned int		period; 	/* in nanoseconds */
> +	unsigned int		duty_cycle;	/* in nanoseconds */
> +	enum pwm_polarity	polarity;
> +};

No need for the extra padding here.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/8de5d90a/attachment.sig>
