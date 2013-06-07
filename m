From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Jun 2013 17:51:24 +0100
Subject: [PATCH 06/10] regulator: ab8500: Ensure AB8500 external
 registers are probed first
In-Reply-To: <1370621488-18130-7-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
 <1370621488-18130-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20130607165124.GY31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 05:11:24PM +0100, Lee Jones wrote:
> This patch changes the order in which the AB8500 regulator drivers are
> registered and subsequently probed. It saves a lot of -EPROBE_DEFEER
> nonsense and bootlog noise, as some AB8500 core regulators depend on
> the external ones for supply voltage.

When CCing maintainers on patches please use the e-mail addresses they
advertise and generally use...  applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130607/7ff88e15/attachment.sig>
