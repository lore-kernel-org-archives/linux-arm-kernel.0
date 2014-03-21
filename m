From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Mar 2014 18:20:39 +0000
Subject: [PATCH] regulator: Add new driver for ST's PWM controlled
 voltage regulators
In-Reply-To: <1395397296-8196-1-git-send-email-lee.jones@linaro.org>
References: <1395397296-8196-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140321182039.GQ552@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 10:21:36AM +0000, Lee Jones wrote:
> On some STMicroelectronics hardware reside regulators consisting
> partly of a PWM input connected to the feedback loop. As the PWM
> duty-cycle is varied the output voltage adapts. This driver
> allows us to vary the output voltage by adapting the PWM input
> duty-cycle.

Applied, thanks.  Please send incremental fixes for the things Josh
mentioned.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/529ab997/attachment.sig>
