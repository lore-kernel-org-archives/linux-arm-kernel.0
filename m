From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 24 Jan 2018 07:35:07 +0100
Subject: [PATCH v4 0/3] i2c: mv64xxx: Fix clock resource for Armada 7K/8K
In-Reply-To: <20180116163540.1092-1-gregory.clement@free-electrons.com>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
Message-ID: <20180124063507.swvhh3cy5au2bfbu@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 05:35:37PM +0100, Gregory CLEMENT wrote:

> This short series fixes the way the clocks are used for the mv64xxx
> controller embedded in the Marvell Armada 7K/8K SoCs. On these SoCs a
> second one is needed in order to clock the registers. It was not
> noticed until now because we relied on the bootloader and also because
> the clock driver was wrong.
> 
> Thanks to this fix, it would be possible to fix the clock driver
> without introducing a regression.
> 
> The first patch is just a small cleanup found when I wrote the main
> patch.
> 
> The last patch is not related to the series but as Wolfram to have a
> maintainer for this driver I added the patch here.

Thomas, Andrew, Maxime, any tags you'd like to donate?

>  - Add a maintainer for the i2c-mv64xxx driver, requested

Well, I'd say "asked for"...

> by Woflram Sang

... whoever that guy is ;)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180124/a7061a6c/attachment.sig>
