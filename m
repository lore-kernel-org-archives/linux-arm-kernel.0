From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 19 Mar 2013 20:48:41 +0100
Subject: [BUG][mvebu] mvneta: cannot request irq 25 on openblocks-ax3
In-Reply-To: <514895C5.40706@free-electrons.com>
References: <51486445.8040506@hitachi.com> <514873FB.5050202@hitachi.com>
 <514895C5.40706@free-electrons.com>
Message-ID: <2482565.pAEcuMH9qj@bender>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 March 2013 17:43:49 Gregory CLEMENT wrote:
> 
> Hi Masami,
> 
> You can try this patch if you want.
> I don't have the hardware today so I didn't test it.
> If you (and also Florian and Ezequiel) can test it and if it fixed
> the bug, then I will be able send a proper email for it,

I just tested your patch on RD-A370-A1 and DB-MV784MP-GP and it works fine, 
thanks! Feel free to add my Tested-by: Florian Fainelli <florian@openwrt.org> 
to your next submission.

Thanks!
-- 
Florian
