From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Jan 2015 15:29:58 +0000
Subject: [PATCH] ASoC: ts3a227e: Check and report jack status at probe
In-Reply-To: <1420457219-23098-1-git-send-email-cychiang@chromium.org>
References: <1420457219-23098-1-git-send-email-cychiang@chromium.org>
Message-ID: <20150105152958.GU11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 07:26:59PM +0800, Cheng-Yi Chiang wrote:
> ts3a227e does not trigger interrupt to report jack status when system
> boots from warm reset because ts3a227e's power remains on during warm reset.
> Read jack status at probe to get current jack status.
> Note that if system boots from EC reset, then this issue will not
> happen.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/dcd19008/attachment.sig>
