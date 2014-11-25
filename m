From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Nov 2014 13:59:42 +0100
Subject: [PATCH v3 0/5] Add Spreadtrum Sharkl64 Platform support
In-Reply-To: <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <5003189.80rNq67D5Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 November 2014 20:16:53 Chunyan Zhang wrote:
> Spreadtrum is a rapid growing chip vendor providing smart phone total solutions.
> 
> Sharkl64 Platform is nominated as a SoC infrastructure that supports 4G/3G/2G
> standards based on ARMv8 multiple core architecture.Now we have only one
> SoC(SC9836) based on this Platform in developing.
> 
> This patchset adds Sharkl64 support in arm64 device tree and the serial driver
> of SC9836-UART.
> 
> This patchset also has patches which address "sprd" prefix and DT compatible
> strings for nodes which appear un-documented.
> 
> This version code was tesed on Fast Mode.
> We use boot-wrapper-aarch64 as the bootloader.

Looks very good overall. I have two small comments to individual patches,
but I think we can still merge them for 3.19. Please send the serial
driver to Greg for inclusion, unless you get further comments, and send
the updated version of the other patches to arm at kernel.org and ask
for including them in the cover letter.

	Arnd
