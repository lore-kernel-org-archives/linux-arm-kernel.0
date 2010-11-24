From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 24 Nov 2010 16:31:07 +0100
Subject: rm9200: update
In-Reply-To: <20101124143448.GH11909@game.jcrosoft.org>
References: <20101120095906.GD4216@game.jcrosoft.org>
	<20101124143448.GH11909@game.jcrosoft.org>
Message-ID: <4CED2FBB.8040702@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On 24/11/2010 15:34, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 	version 2
>
> 	replace
> 	at91/picotux200: fix warning: 'picotux200_mmc_data' defined but not used
> 	by
> 	at91/picotux200: remove commenting usb device and dataflash support
>
> 	fix comments
> 	and add
> 	at91/board-yl-9200: fix typo in video support
>
as you seem to have access to several AT91RM9200 based boards, can you test 
this patch on them : http://www.spinics.net/lists/arm-kernel/msg101658.html ?

Thanks
Eric
