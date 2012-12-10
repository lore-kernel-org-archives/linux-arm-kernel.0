From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 10 Dec 2012 13:50:19 +0100
Subject: [PATCH 1/3] atmel_lcdfb: fix 16-bpp modes on older SOCs
In-Reply-To: <1355142530-10366-2-git-send-email-jhovold@gmail.com> (Johan
 Hovold's message of "Mon, 10 Dec 2012 13:28:48 +0100")
References: <1355142530-10366-1-git-send-email-jhovold@gmail.com>
 <1355142530-10366-2-git-send-email-jhovold@gmail.com>
Message-ID: <87wqwqrrzo.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Johan" == Johan Hovold <jhovold@gmail.com> writes:

 Johan> Fix regression introduced by commit 787f9fd23283 ("atmel_lcdfb: support
 Johan> 16bit BGR:565 mode, remove unsupported 15bit modes") which broke 16-bpp
 Johan> modes for older SOCs which use IBGR:555 (msb is intensity) rather
 Johan> than BGR:565.

 Johan> Use SOC-type to determine the pixel layout.

 Johan> Tested on custom at91sam9263-board.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
