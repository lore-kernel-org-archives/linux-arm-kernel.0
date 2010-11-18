From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 18 Nov 2010 13:27:32 -0500 (EST)
Subject: [PATCH 9/9] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C05986C79AA@SC-VEXCH1.marvell.com>
References: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-2-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-3-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-4-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-5-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-6-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-7-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-8-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-9-git-send-email-haojian.zhuang@marvell.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C05986C77F4@SC-VEXCH1.marvell.com>
	<alpine.LFD.2.00.1011171047150.6448@xanadu.home>
	<25B60CDC2F704E4E9D88FFD52780CB4C05986C79AA@SC-VEXCH1.marvell.com>
Message-ID: <alpine.LFD.2.00.1011181325550.6448@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Nov 2010, Haojian Zhuang wrote:
[...]
> >that required access to it from the moment it was set at the beginning
> >of the function, so maybe you should have only cleared it at the
> >beginning instead.
> >
> >
> >Nicolas
> 
> Thanks for your comments. Now it's fixed in attachment.

Acked-by: Nicolas Pitre <nico@fluxnic.net>


Nicolas
