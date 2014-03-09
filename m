From: broonie@kernel.org (Mark Brown)
Date: Sun, 9 Mar 2014 19:08:07 +0000
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <CAOesGMhUVEEa6KLs2ZORxJunxitVdOQ5-wbs3KtEWBq+77t5JA@mail.gmail.com>
References: <20140309114134.502cdcae7e6a97db684d6b15@kernel.org>
 <CAOesGMhUVEEa6KLs2ZORxJunxitVdOQ5-wbs3KtEWBq+77t5JA@mail.gmail.com>
Message-ID: <20140309190807.GZ28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 09, 2014 at 10:08:58AM -0700, Olof Johansson wrote:
> On Sun, Mar 9, 2014 at 4:41 AM, Mark Brown <broonie@kernel.org> wrote:

> > ERROR: Input tree has errors, aborting (use -f to force output)
> > make[2]: *** [arch/arm/boot/dts/socfpga_arria5_socdk.dtb] Error 2

> Known issue, I unmerged the offending branch but didn't push out the
> backed out for-next branch last night (I was unaware that you were
> doing linux-next now, and sfr doesn't do them until Sunday night our
> time, so I didn't think it was urgent).

No worries, I wouldn't have done it on a Sunday either but this time
round I've got Stephen's scripts so I've been pipe cleaning those so
hopefully everything will actually run properly on Monday.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140309/d8130a81/attachment.sig>
