From: broonie@kernel.org (Mark Brown)
Date: Fri, 30 Jan 2015 14:20:47 +0100
Subject: [PATCH 2/3] ASoC: atmel_ssc_dai: refactor the startup and shutdown
In-Reply-To: <1422610724-7222-3-git-send-email-voice.shen@atmel.com>
References: <1422610724-7222-1-git-send-email-voice.shen@atmel.com>
 <1422610724-7222-3-git-send-email-voice.shen@atmel.com>
Message-ID: <20150130132047.GO26617@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 05:38:43PM +0800, Bo Shen wrote:
> In startup function, enable ssc clock and in shutdown function,
> disable clock. And also remove disable ssc in shutdown function,
> as ssc is disabled in prepare function.

Applied, thanks.  You probably want to convert to clk_prepare_enable()
too but that's a separate thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150130/55eb30de/attachment.sig>
