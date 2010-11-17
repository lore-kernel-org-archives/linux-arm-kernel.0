From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 17 Nov 2010 10:29:22 -0500 (EST)
Subject: [PATCH 9/9] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <1289991823-24677-9-git-send-email-haojian.zhuang@marvell.com>
References: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-2-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-3-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-4-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-5-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-6-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-7-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-8-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-9-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <alpine.LFD.2.00.1011171026550.6448@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Nov 2010, Haojian Zhuang wrote:

> iwmmxt is used in XScale, XScale3, Mohawk and PJ4 core. But the instructions
> of accessing CP0 and CP1 is changed in PJ4. Append more files to support
> iwmmxt in PJ4 core.
> 
> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>


Did you forget to do "git add pj4-cp0.c"?  It is missing from your 
patch.


Nicolas
