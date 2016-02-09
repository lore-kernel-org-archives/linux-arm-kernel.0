From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 9 Feb 2016 14:18:16 -0800
Subject: [PATCH 0/3] randconfig warning fixes for thermal
In-Reply-To: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
References: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
Message-ID: <20160209221815.GE28102@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 05:44:09PM +0100, Arnd Bergmann wrote:
> These are three simple fixes for ARM randconfig builds:
> 
>  [PATCH 1/3] thermal: spear: use __maybe_unused for PM functions
>  [PATCH 2/3] thermal: allow spear-thermal driver to be a module
>  [PATCH 3/3] thermal: allow u8500-thermal driver to be a module
> 
> All three bugs are on configurationsn that are not important and
> that rarely happen even with randconfig builds.
> 
> 	Arnd

Thanks a lot for your cleanups Arnd,
queueing all three.

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/57f41a2f/attachment.sig>
