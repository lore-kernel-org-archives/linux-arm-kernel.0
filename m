From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Thu, 04 Nov 2010 23:53:41 +0100
Subject: [PATCHv2 2/2] ARM: imx: Add mx53 support to common msl functions.
In-Reply-To: <1288910773-3098-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1288910773-3098-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1288910773-3098-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <4CD33975.4010100@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

Le 04/11/2010 23:46, Dinh.Nguyen at freescale.com a ?crit :
> From: Dinh Nguyen<Dinh.Nguyen@freescale.com>
>
> Add mx53 support to cpu.c and mm.c.
>
> Also change the method to get the silicon version from the
> documented IIM SREV register instead of reading the ROM code.
>
if iMX5x IIM is like iMX27/31/35, you may need to enable the iim clock before 
accessing the registers.

Eric
