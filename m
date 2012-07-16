From: pavel@denx.de (Pavel Machek)
Date: Mon, 16 Jul 2012 23:37:53 +0200
Subject: [RFC PATCHv2 0/2]arm: socfpga: Add initial support for Altera's
 SOCFPGA HW
In-Reply-To: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
Message-ID: <20120716213752.GA28680@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Arnd, do you think this is good enough to go to the next tree? It
is new architecture, it should not break anything, I believe we
addressed all the issues raised in the review, and noone is reporting
new ones.

Plus, if we could make initial support into 3.6, that would be very
nice :-).

Thanks,
									Pavel

On Thu 2012-07-12 12:26:14, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> This patch series add minimal support for Altera's SOCFPGA hardward.
> 
> Changes since v1:
> - Incorporate changes suggested by Pavel Machek, Thommas Petazzoni,
>   Arnd Bergmann, and Rob Herring
> - Reduce the patch to a make as much use of DTS as possible
> 
> 
> Dinh Nguyen (2):
>   ARM: socfpga: initial support for Altera's SOCFPGA platform.
>   ARM: socfpga: Add board support for Altera's SOCFPGA Cyclone 5 HW
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
