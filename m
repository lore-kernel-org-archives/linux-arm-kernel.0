From: pavel@denx.de (Pavel Machek)
Date: Tue, 9 Jun 2015 11:46:55 +0200
Subject: [PATCHv6 1/2] ARM: socfpga: support suspend to ram
In-Reply-To: <1433270139-7042-2-git-send-email-atull@opensource.altera.com>
References: <1433270139-7042-1-git-send-email-atull@opensource.altera.com>
 <1433270139-7042-2-git-send-email-atull@opensource.altera.com>
Message-ID: <20150609094655.GA6539@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> +/* Bitfield positions */
> +#define SELFRSHREQ_POS                  3
> +#define SELFRFSHACK_POS                 1

These two defines are unused and should be deleted.

Thanks,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
