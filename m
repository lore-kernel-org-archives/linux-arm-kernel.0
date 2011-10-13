From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 13 Oct 2011 16:44:35 +0200
Subject: [PATCH] atmel_lcdfb: support new-style palette format
In-Reply-To: <1318507395-23143-1-git-send-email-jacmet@sunsite.dk> (Peter
	Korsgaard's message of "Thu, 13 Oct 2011 14:03:14 +0200")
References: <1318507395-23143-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <878vopuf1o.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

 Peter> The newer Atmel SoCs use normal 16bit 565 BGR/RGB for the palette data,
 Peter> rather than the special intensity + 555 format.

 Peter> Fill out palette data correctly on these devices, and at the same time
 Peter> respect the RGB/BGR wiring mode.

Ups, wrong patch - This has RGB/BGR modes swapped. Will resend.

-- 
Bye, Peter Korsgaard
