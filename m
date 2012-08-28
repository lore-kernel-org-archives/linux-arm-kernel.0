From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 28 Aug 2012 13:33:37 +0800
Subject: [PATCH v2 5/7] ARM: imx6q: convert to use syscon to access
 anatop registers
In-Reply-To: <20120828032309.GW4011@b20223-02.ap.freescale.net>
References: <1346052285-4344-1-git-send-email-b29396@freescale.com>
 <1346052285-4344-6-git-send-email-b29396@freescale.com>
 <20120828032309.GW4011@b20223-02.ap.freescale.net>
Message-ID: <20120828053336.GF5822@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 11:23:10AM +0800, Zhao Richard-B20223 wrote:
...
> >  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
> np unused.

Correct.
Will drop it.

Regards
Dong Aisheng
