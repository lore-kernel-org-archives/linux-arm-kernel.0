From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jul 2015 14:32:45 +0100
Subject: [RESEND 09/10] regulator: pwm-regulator: Simplify voltage to
 duty-cycle call
In-Reply-To: <1436173112-21397-10-git-send-email-lee.jones@linaro.org>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
 <1436173112-21397-10-git-send-email-lee.jones@linaro.org>
Message-ID: <20150707133245.GM2887@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 09:58:31AM +0100, Lee Jones wrote:
> If we reverse some of the logic and change the formula used,
> we can simplify the function greatly.

> +static int pwm_voltage_to_duty_cycle(struct regulator_dev *rdev, int req_uV)
>  {
> -	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);

You just added this function in the previous patch?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150707/45a5820d/attachment.sig>
