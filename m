From: broonie@kernel.org (Mark Brown)
Date: Tue, 1 Aug 2017 15:21:17 +0100
Subject: [PATCH] ASoC: improve RT5514 dependencies
In-Reply-To: <s5hh8xt0xwy.wl-tiwai@suse.de>
References: <20170731083217.4142512-1-arnd@arndb.de>
 <s5hh8xt0xwy.wl-tiwai@suse.de>
Message-ID: <20170801142117.oc3owynj74g5bmyi@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 11:15:57AM +0200, Takashi Iwai wrote:

> IMO, flipping the dependency looks saner to me.  The SPI function call
> is a kind of add-on, after all.

Yes, that's definitely the intention of the code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170801/ea0bde7e/attachment.sig>
