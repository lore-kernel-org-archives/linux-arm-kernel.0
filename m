From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 17:34:19 +0000
Subject: [PATCH v2 1/2] ASoC: atmel_ssc_dai: fix start event for I2S mode
In-Reply-To: <1421739797-25988-1-git-send-email-voice.shen@atmel.com>
References: <1421739797-25988-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20150127173419.GB21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 03:43:16PM +0800, Bo Shen wrote:
> According to the I2S specification information as following:
>   - WS = 0, channel 1 (left)
>   - WS = 1, channel 2 (right)
> So, the start event should be TF/RF falling edge.

applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/b85ac468/attachment.sig>
