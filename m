From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Jun 2013 17:52:27 +0100
Subject: [PATCH 07/10] regulator: ab8500-ext: Provide a set_voltage
 call-back operation
In-Reply-To: <1370621488-18130-8-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
 <1370621488-18130-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20130607165227.GZ31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 05:11:25PM +0100, Lee Jones wrote:
> When registering regulators which have a single voltage through Device
> Tree, the framework insists that the specified voltage is actually set.
> Well in order to do that we need to provide this call-back, where we
> check that the value is sane and return without error. Not that the
> selector isn't populated, but in our case list_voltage doesn't actually
> use it, so we're good.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130607/86432a13/attachment.sig>
