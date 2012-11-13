From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Nov 2012 18:41:46 +0900
Subject: [PATCH v5 2/3] ASoC: atmel-ssc-dai: register dai and pcm directly
In-Reply-To: <50A214FC.90201@atmel.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-3-git-send-email-voice.shen@atmel.com>
 <20121113083031.GP18224@opensource.wolfsonmicro.com>
 <50A20E82.9020704@atmel.com>
 <20121113092038.GU18224@opensource.wolfsonmicro.com>
 <50A214FC.90201@atmel.com>
Message-ID: <20121113094145.GV18224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 05:38:04PM +0800, Bo Shen wrote:
> On 11/13/2012 17:20, Mark Brown wrote:

> >The machine driver should know which SSC it is using all by itself, it's
> >specific to a particular machine.  This is how it's been doing it since
> >it was written...

> So, you mean, I should hard code this into machine driver, am I right?

Yes, exactly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/eb88c307/attachment.sig>
