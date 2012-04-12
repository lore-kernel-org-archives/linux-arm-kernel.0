From: cjb@laptop.org (Chris Ball)
Date: Thu, 12 Apr 2012 00:54:34 -0400
Subject: linux-next: manual merge of the arm-soc tree with the mmc tree
In-Reply-To: <20120412140206.704731281bf2ee7d93d582bf@canb.auug.org.au>
 (Stephen Rothwell's message of "Thu, 12 Apr 2012 14:02:06 +1000")
References: <20120412140206.704731281bf2ee7d93d582bf@canb.auug.org.au>
Message-ID: <87pqbdr1md.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 12 2012, Stephen Rothwell wrote:
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/mmc/host/Kconfig between commit a334b9550294 ("mmc: remove imxmmc
> driver") from the mmc tree and commits a21a92c0c787 ("mmc: Kconfig: remove
> choice between at91_mci and atmel-mci") and 62080f06de6b ("mmc:
> atmel-mci: remove the need for CONFIG_MMC_ATMELMCI_DMA") from the arm-soc
> tree.
>
> I fixed it up (see below) and can carry the fix as necessary.

Thanks, Stephen.

Nicolas and Arnd, these MMC Kconfig patches weren't sent to me or
linux-mmc@ for review, so I haven't seen them before.  They look
fine, but I'd like to be in the loop directly to avoid surprises.

Do these MMC patches have any dependency on other work?  It doesn't
look like it.  If that's so, I'd rather carry them in the MMC tree
to save Stephen and Linus from dealing with the merge conflict.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
