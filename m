From: lost.distance@yahoo.com (Paul Parsons)
Date: Sun, 15 May 2011 14:27:51 +0100 (BST)
Subject: [PATCH] pxa/hx4700: Fix basic suspend/resume
In-Reply-To: <20110515131416.GA3954@rainbow>
Message-ID: <678981.96772.qm@web29003.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

> Well, it really seems to make all those "Spurious IRQ"
> messages disappear.
> (and btw, MMC magically started to work for me in -rc7.
> Probably that were
> some earlier -rc's that didn't work and issue was fixed in
> -rc7. Or maybe
> I'm just lucky today)

That's good news.

> I think it's worth to submit it to tmio_mmc maintainers
> along with the
> description of this situation on ASIC3. Even if it won't be
> accepted,
> it'll make them aware of the problem and maybe some clean
> solution could
> be worked out then.

I have just now submitted a patch to linux-mmc.

Regards,
Paul
