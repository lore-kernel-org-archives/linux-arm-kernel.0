From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jun 2015 18:14:42 +0100
Subject: [PATCH 6/8] regulator: pwm-regulator: Separate voltage-table
 initialisation
In-Reply-To: <1433529771-24496-7-git-send-email-lee.jones@linaro.org>
References: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
 <1433529771-24496-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20150609171442.GL14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 05, 2015 at 07:42:49PM +0100, Lee Jones wrote:
> Take this out of the main .probe() routine in order to facilitate the
> introduction of different ways to obtain 'duty cycle' information.

This and the rest of the patches are fine but seem to depend on patch 4
- can you please rebase and resend?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150609/b04d1fad/attachment.sig>
