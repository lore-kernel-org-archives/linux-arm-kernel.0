From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Mon, 28 Sep 2009 09:39:25 +0200
Subject: Problem with mxc_nand driver
In-Reply-To: <a57e67db0909272341k59d4cda6pde85ff7425a75c8f@mail.gmail.com>
References: <a57e67db0909272341k59d4cda6pde85ff7425a75c8f@mail.gmail.com>
Message-ID: <4AC0682D.6000907@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

Jernej Turnsek a ?crit :
> I found a bit strange to set badblock_pattern parameter to
> smallpage_memorybased although pagesize is 2k. Or am I wrong?
> 
> When I revert this patch, everything works as it should.
> 
on my iMX27 board, I have the opposite case with a MT29F4G08ABC : it 
works only with this patch. This code came from the original Freescale 
BSP. I'm going to investigate more on this problem on my board and let 
you know.

Eric
