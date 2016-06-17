From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Jun 2016 13:20:50 +0100
Subject: [PATCH v5] ASoC: rockchip: Add machine driver for RK3399 GRU
 Boards
In-Reply-To: <CAL_JsqKEDw14HmbW=78_4P03nFDfmT7kOn4RsTF-PrBi+jWr0g@mail.gmail.com>
References: <1465807339-1100-1-git-send-email-zhengxing@rock-chips.com>
 <20160614223810.GA7925@rob-hp-laptop>
 <20160615095312.GY2282@sirena.org.uk>
 <CAL_JsqKEDw14HmbW=78_4P03nFDfmT7kOn4RsTF-PrBi+jWr0g@mail.gmail.com>
Message-ID: <20160617122050.GL26099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 07:44:32AM -0500, Rob Herring wrote:
> On Wed, Jun 15, 2016 at 4:53 AM, Mark Brown <broonie@kernel.org> wrote:

> > There's no point in standard property names if the interpretation has to
> > be non-standard.

> Okay, I agree with the system specific interpretation part. However, I
> don't think using simple-card or not determines using common
> properties.

The point here is that if those properties were to have a standard
meaning the system would be using simple-card anyway, the meaning is
entirely in the context of the card.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160617/8982dd54/attachment.sig>
