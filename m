From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Tue, 04 Feb 2014 20:37 +0100
Subject: [PATCH v2 0/6] ARM: sunxi: Add driver for SD/MMC hosts found on
 allwinner sunxi SOCs
In-Reply-To: <20140204191648.29809.14611.stgit@dizzy-6.o2s.ch>
References: <20140204191648.29809.14611.stgit@dizzy-6.o2s.ch>
Message-ID: <2036604.9RXHkpag8W@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
I forgot to mention that the autoparenting patch of Emilios is a crucial 
depency...
http://git.o2s.ch/?p=linux-next.git;a=commit;h=f8e936772672a3a6ec934558d2a7aef030c663c4
Without it, the clock will return the wrong value and the card will refuse to 
initialize

regards
david
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/201e6182/attachment.sig>
