From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Oct 2015 16:15:25 +0100
Subject: [alsa-devel] [PATCH v2 1/3] ASoC: rockchip: i2s: add 8 channels
 capture support
In-Reply-To: <CAG5mAdzfoK_rnQhu=NGMzto2K49uKT4eOotRh3uGX=D6KOB5gQ@mail.gmail.com>
References: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
 <1444308009-29088-2-git-send-email-sugar.zhang@rock-chips.com>
 <CAG5mAdzfoK_rnQhu=NGMzto2K49uKT4eOotRh3uGX=D6KOB5gQ@mail.gmail.com>
Message-ID: <20151019151525.GA32054@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 07:30:43AM -0700, Caleb Crome wrote:
> Is it possible to allow channels > 8 if certain requirements are met?  If
> the rockchip supports 8 channels @ 32-bits/sample, that means 256
> bits/frame.  Can those 256 bits be sliced into 16 channels of 16-bit
> samples?

Please don't top post.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151019/f8e1dd2e/attachment.sig>
