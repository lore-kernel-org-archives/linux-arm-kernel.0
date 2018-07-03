From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Jul 2018 00:37:59 -0700
Subject: [RFC 0/5] Migrate AM35xx MUSB glue to device tree and enable MUSB
In-Reply-To: <20180625001233.9785-1-aford173@gmail.com>
References: <20180625001233.9785-1-aford173@gmail.com>
Message-ID: <20180703073759.GQ112168@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adam Ford <aford173@gmail.com> [180624 17:15]:
> 
> It currently doesnt' work, but I am looking for ideas on
> what I may have missed or done incorrectly.  

Check the drivers/phy/ti driver part and make sure that
works and has pins and clocks configured.

The rest should be pretty much generic stuff for musb
as long as the SoC glue layer can deal with the module,
clocks and pins.

Regards,

Tony
