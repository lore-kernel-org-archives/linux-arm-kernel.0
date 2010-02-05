From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Fri, 05 Feb 2010 18:27:53 +0100
Subject: [PATCHv3 5/7] mxc: Add support for the Babbage board (i.MX5)
In-Reply-To: <ef6149ed5e1d228262c3d98421a836400095c1b7.1265385421.git.amit.kucheria@canonical.com>
References: <cover.1265385421.git.amit.kucheria@canonical.com>	<367110fafb57f7340bbffec9b394ed2fa6e89da5.1265385421.git.amit.kucheria@canonical.com>	<553d86cf968ba78a26b67098c2e1849407a51ba1.1265385421.git.amit.kucheria@canonical.com>	<bf84de08e5c511325fb94a742f5d6efabece06b6.1265385421.git.amit.kucheria@canonical.com>	<7739120baf6088e426f3f8bab174f6c6a6df3601.1265385421.git.amit.kucheria@canonical.com>
	<ef6149ed5e1d228262c3d98421a836400095c1b7.1265385421.git.amit.kucheria@canonical.com>
Message-ID: <4B6C5519.2070506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Kucheria skrev:
> Babbage is a reference board from Freescale for their i.MX51 SoC.
> 
> Add board definition, Kconfig and Makefiles to enable Freescale i.MX51
> processor and Babbage board.
> 
> Boot tested on a Babbage2.5 board

In u-boot this board, and the files, are called mx51evk instead of Babbage. It would be nice if the same name is used in both, but no big issue.

Regards, Magnus
