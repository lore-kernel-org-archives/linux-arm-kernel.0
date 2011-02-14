From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Feb 2011 10:00:38 +0100
Subject: [RFC] Inter-processor Mailboxes Drivers
In-Reply-To: <20110214.105553.296482686007701595.Hiroshi.DOYU@nokia.com>
References: <AANLkTikoExk30pqdcHXCA2K_oJB=VJ5_AnCkoYUrEt3X@mail.gmail.com>
	<20110214.093257.58795266617213863.Hiroshi.DOYU@nokia.com>
	<AANLkTimnHHhYKnvUgsMo_jsKaYdY+XuABZ+FV0p25JLi@mail.gmail.com>
	<20110214.105553.296482686007701595.Hiroshi.DOYU@nokia.com>
Message-ID: <AANLkTikdNW1k9ym9kHbMxRTEmOfTsvCTYzKp8ypqrWG+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 9:55 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:

> Does db5500 use IOMMU for mapping shared memories?

Nope, it's a fixed physical allocation from the modem side
of the world.

Yours,
Linus Walleij
