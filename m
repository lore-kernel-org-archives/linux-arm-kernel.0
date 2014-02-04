From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 19:20:41 +0000
Subject: [PATCH 10/17] spi: pl022: Remove redundant pinctrl to default
 state in probe
In-Reply-To: <1391529538-21685-11-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-11-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140204192041.GW22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 04:58:51PM +0100, Ulf Hansson wrote:
> The driver core is now taking care of putting our pins into default
> state at probe. Thus we can remove the redundant call for it in probe.

I applied this one too, as with the last patch it looks independant of
the runtime PM stuff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/a1237526/attachment.sig>
