From: Colin.Tuckley@arm.com (Colin Tuckley)
Date: Wed, 7 Jul 2010 09:47:54 +0100
Subject: [PATCH 1/3] ARM: driver for the character LCD found in ARM
	refdesigns
In-Reply-To: <1278429668-4564-1-git-send-email-triad@df.lth.se>
References: <1278429668-4564-1-git-send-email-triad@df.lth.se>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA42DA39B5220@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> kernel-bounces at lists.infradead.org] On Behalf Of Linus Walleij

> This adds a driver for the character LCD found on the ARM Versatile
> and RealView Platform Baseboards. It doesn't do very much more than
> display the text "ARM Linux" on the first line and the linux banner
> on the second line, but that's still useful.

> The 4bit mode is the only one that seems to work. I tried putting
> the display into 8bit mode and failed miserably.

I've had a check with the hardware guys. Our self-test software uses the 4-bit mode, the 8-bit mode is untested.


> The IRQ is stated in the reference manual as "don't use" because it
> is "reserved for future use" but I implemented it anyway.

The answer seems to be that "future use" means "for an OS".

Colin

--
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
