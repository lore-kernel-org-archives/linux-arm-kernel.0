From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 12 Mar 2015 15:50:49 +0100
Subject: [RFC V2 03/12] i2c: at91: make use of the new infrastructure for
 quirks
In-Reply-To: <20150310135520.GY9132@odux.rfo.atmel.com>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-4-git-send-email-wsa@the-dreams.de>
 <20150308082845.GB1904@katana>
 <20150310135520.GY9132@odux.rfo.atmel.com>
Message-ID: <20150312145049.GA9572@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> You can add my 
> 
> Acked-by and Tested-By: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Tested on sama5d3, some problems with at24 eeprom on sama5d4 but it
> doesn't come from the i2c quirks patch series.

Thanks for testing! Are the eeprom problems something which needs fixing
upstream?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150312/89ca0cda/attachment.sig>
