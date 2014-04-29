From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Tue, 29 Apr 2014 23:55:19 +0200
Subject: [PATCH v9 05/17] ARM: dts: sun4i: Add pin-muxing info for the
 mmc0 controller
In-Reply-To: <535F60D7.1080500@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
 <20140428193210.GF3134@lukather> <535F60D7.1080500@redhat.com>
Message-ID: <1470138.BWEKSClG2D@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
> Ok will fix this up for the next version.
Be carefull!
I removed redundancies on all the boards I've seen so far, which all had the
same pin assignment, based on the reference design of Allwinners.
Please make sure the boards pin muxing fits onto your board.
Certain boards differ within their muxing.

br
-- 
David Lanzend?rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140429/58b10bcc/attachment.sig>
