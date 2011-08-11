From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 11 Aug 2011 14:50:16 +0200
Subject: [PATCH 05/12] ARM: mach-s5pv210: Setup consistent dma size at
	boot time
In-Reply-To: <1312813712-22808-6-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
	<1312813712-22808-6-git-send-email-tixy@yxit.co.uk>
Message-ID: <20110811125016.GD24434@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -#define CONSISTENT_DMA_SIZE	(SZ_8M + SZ_4M + SZ_2M)
...
> +	init_consistent_dma_size(14 << 20);

Are you sure that's equivalent?
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
