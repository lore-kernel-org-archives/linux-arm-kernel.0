From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Jan 2012 15:59:22 -0800
Subject: [PATCH 6/9] arch/arm/mach-omap2/devices.c: introduce missing kfree
In-Reply-To: <1324661974-17281-6-git-send-email-julia@diku.dk>
References: <1324661974-17281-6-git-send-email-julia@diku.dk>
Message-ID: <20120126235922.GE29812@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Julia Lawall <julia@diku.dk> [111223 09:07]:
> pdata needs to be freed before leaving the function in an error case.

Thanks applying into fixes.

Tony
