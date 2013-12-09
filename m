From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 02:33:58 +0100
Subject: [PATCH 5/9] ARM: dts: provide DMA config to pxamci
In-Reply-To: <1386543229-1542-6-git-send-email-ynvich@gmail.com>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-6-git-send-email-ynvich@gmail.com>
Message-ID: <201312090233.58592.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 December 2013, Sergei Ianovich wrote:
> Non-dts implementation supply required DMA channel numbers as
> IORESOURCE_DMA. However, there is was no way to get them from
> device tree.

I just wrote a lengthy reply to this email to explain in what ways
you got it wrong, but then I saw that Daniel has already done all
the work in the right way in August, so nevermind that.

It hasn't made it upstream yet, but see http://list-archives.org/2013/08/07/linux-mtd-lists-infradead-org/patch-00-20-arm-pxa-move-core-and-drivers-to-dmaengine/f/3444199144
for how it's done. Maybe Daniel can comment on the status of his
patches.

	Arnd
