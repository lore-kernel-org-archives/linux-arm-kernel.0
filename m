From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Apr 2012 20:14:49 +0000
Subject: [PATCH 2/9] ARM: mmp: distinguish mmp and mmp2 in Kconfig
In-Reply-To: <1335515957-1798-3-git-send-email-haojian.zhuang@gmail.com>
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
 <1335515957-1798-3-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201204272014.49443.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2012, Haojian Zhuang wrote:
> Append four CONFIG_* MACRO to distinguish boards in arch-mmp.
> 
> CONFIG_MMP_LEGACY and CONFIG_MMP2_LEGACY are used to support boards
> without device tree.
> 
> CONFIG_MMP_DT and CONFIG_MMP2_DT are used to support boards with
> device tree.
> 
> At the same time, only one of these four macro could be selected.
> It's used to miss compiling all boards file together.

Can you explain why this is done? It seems counterintuitive to
have the DT and non-DT support be mutually exclusive.

	Arnd
