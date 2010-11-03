From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 3 Nov 2010 15:02:36 +0200
Subject: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board
	file
In-Reply-To: <1285596710-25658-5-git-send-email-s-ghorai@ti.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
	<1285596710-25658-5-git-send-email-s-ghorai@ti.com>
Message-ID: <AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 27, 2010 at 5:11 PM, Sukumar Ghorai <s-ghorai@ti.com> wrote:
> This patch makes it possible to select sw or hw (different layout options)
> ecc scheme supported by omap nand driver. ?And hw ecc layout selected for
> sdp and zoom boards, by default.
>
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>

Any news on this? Commit 2c01946c accidentally (?) enabled hardware
ECC and now my board is broken, as the driver always used sw ecc and
my NAND partitions are formatted accordingly. We should at least
switch the default back to sw ecc, don't you think?
