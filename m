From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Mar 2011 15:55:32 +0100
Subject: [PATCH 1/4] amba: add name based matching
In-Reply-To: <20110315144925.GG3921@n2100.arm.linux.org.uk>
References: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
	<1300200116-12185-2-git-send-email-philippe.langlais@stericsson.com>
	<20110315144925.GG3921@n2100.arm.linux.org.uk>
Message-ID: <AANLkTineh_XDPgkf04R61PHkiGBE2=Mc0cw6fvt3AuNL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2011 at 3:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> I really hate the idea of matching AMBA stuff by name. ?Isn't there any
> other solution to this?

The second option I would try is to add a field to the platform data
for pl022 and mmci/pl180 such as "u8 silicon_revision" and encode
that with some 0x01, 0x02, 0x03... for the silicon revisions that
matter to behaviour.

Would you prefer this approach?

Yours,
Linus Walleij
