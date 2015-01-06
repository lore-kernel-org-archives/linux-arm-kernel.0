From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Jan 2015 17:45:21 +0000
Subject: [PATCH] ASoC: sam9g20_wm8731: drop machine_is_xxx
In-Reply-To: <1420542872-10015-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1420542872-10015-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150106174521.GM2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 12:14:32PM +0100, Alexandre Belloni wrote:
> Atmel based boards can now only be used with device tree. Drop non DT
> initialization.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/24af0653/attachment.sig>
