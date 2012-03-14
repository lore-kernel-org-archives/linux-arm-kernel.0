From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 14 Mar 2012 21:52:39 +0100
Subject: [PATCH v4 01/10] PWM: add pwm framework support
In-Reply-To: <1331740593-10807-2-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-2-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F610517.7090006@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 04:56 PM, Thierry Reding wrote:
> [...]
> +struct pwm_chip {
> +	int			pwm_id;
> +	const char		*label;
> +	struct pwm_ops		*ops;

Nothing major, but if you are going for another round it would be good to see
ops made const.

> +};
