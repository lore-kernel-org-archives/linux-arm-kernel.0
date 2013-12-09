From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 02:51:44 +0100
Subject: [PATCH 0/9] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
Message-ID: <201312090251.45207.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 December 2013, Sergei Ianovich wrote:
> 
> Except for defconfig, this is a completely new series. The first
> eight patches fix outstanding issues with device tree support
> in PXA. The 9th boots ICP DAS LP-8x4x.

Awesome! That was very quick. The main comment I have is for the
dmaengine support, you will need to rebase on Daniel's patches for
that. I also found few minor details.

	Arnd
