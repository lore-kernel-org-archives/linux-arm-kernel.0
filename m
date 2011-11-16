From: vapier@gentoo.org (Mike Frysinger)
Date: Wed, 16 Nov 2011 13:38:46 -0500
Subject: [PATCH 3/4] mmc: Logging neatening
In-Reply-To: <CAKYAXd8_mDF68PnEnpuZZQ+O8-QmrfRpP4jv+SpHDx1juTxFGQ@mail.gmail.com>
References: <cover.1321398814.git.joe@perches.com>
 <d2c1a76fea1844ae7ac3e7e17183fb39df19178e.1321398814.git.joe@perches.com>
 <CAKYAXd8_mDF68PnEnpuZZQ+O8-QmrfRpP4jv+SpHDx1juTxFGQ@mail.gmail.com>
Message-ID: <201111161338.53049.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 November 2011 20:48:05 NamJae Jeon wrote:
> 2011/11/16 Joe Perches <joe@perches.com>:
> >        mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci
> > interrupt */
> > 
> > -       dev_info(&pdev->dev, "DW MMC controller at irq %d, "
> > -                "%d bit host data width, "
> > -                "%u deep fifo\n",
> > +       dev_info(&pdev->dev,
> > +       "DW MMC controller at irq %d, %d bit host data width, %u deep
> > fifo\n", irq, width, fifo_size);
> 
> I think that tab is needed this "DW MMC controller at irq ...." ?

looks to me like this was the only part you replied to.  could you please snip 
the unrelated context in the future ?  no reason to include ~1700 lines of 
context when you only replying to like ~10 lines.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111116/43f34bba/attachment.sig>
