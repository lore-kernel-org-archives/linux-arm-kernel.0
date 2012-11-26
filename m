From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Nov 2012 10:36:48 +0100
Subject: [PATCH 3/3] ASoC: atmel-pcm: add dma support
In-Reply-To: <50B2CE2C.4080700@atmel.com>
References: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
 <1353651257-2476-4-git-send-email-voice.shen@atmel.com>
 <20121123142747.GP4529@opensource.wolfsonmicro.com>
 <50B2CE2C.4080700@atmel.com>
Message-ID: <20121126093647.GA9411@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 10:04:28AM +0800, Bo Shen wrote:

> I am not sure I got your means.
> As I understand, I should keep the driver using pdc and won't touch it.
> And create new a new driver using dma, am I right?

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/08d37ce2/attachment-0001.sig>
