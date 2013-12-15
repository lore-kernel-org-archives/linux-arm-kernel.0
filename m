From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Sun, 15 Dec 2013 22:19:56 +0100
Subject: [linux-sunxi] Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
In-Reply-To: <52AE0E87.2040304@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <2378731.6b9MyH8v8A@dizzy-6.site> <52AE0E87.2040304@redhat.com>
Message-ID: <1743952.noztKtcF2Y@dizzy-6.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > [...]
> > Do you have something like this in mind? ->
> > drivers/mmc/host/dw_mmc-exynos.c
> No, as explained in my previous mail the idmac being shared seemed to be the
> only 2 things the dw-mmc controller and the sunxi-mmc controller have in
> common.
Ok.

> Looking at dw_mmc-exynos.c it still pretty much is the classic dw-mmc
> controller with some extra bits, where as the sunxi controller is
> significantly different (which allows us to write a significant simpler
> driver).
Do you have an outline for such a driver as you imagine it?
I'd be interested into some "experiments".
Maybe you have a repository where you could push a dedicated tree
for some colaboration on this?

regards
David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131215/87862fea/attachment.sig>
