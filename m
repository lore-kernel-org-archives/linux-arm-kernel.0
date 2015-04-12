From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 12 Apr 2015 16:00:23 -0700
Subject: [PATCH v4 6/6] hwmon: pwm-fan: Update the duty cycle inorder
 to control the pwm-fan
In-Reply-To: <1428864251-31780-7-git-send-email-linux.amoon@gmail.com>
References: <1428864251-31780-1-git-send-email-linux.amoon@gmail.com>
 <1428864251-31780-7-git-send-email-linux.amoon@gmail.com>
Message-ID: <552AF907.5000600@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2015 11:44 AM, Anand Moon wrote:
> pwm_config() must be called with a duty cycle of 0 prior to calling
> pwm_disable() to ensure that the pwm signal is set to low.
>
> Changes since v1 : None.
> Changes since v2 : None
> Changes since v3 : Simplify the comment.
>
> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
> Reviewed-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Applied to hwmon-next (after removing the changelog from
the commit message).

Thanks,
Guenter
