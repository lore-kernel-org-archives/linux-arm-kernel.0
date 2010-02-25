From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 25 Feb 2010 11:58:43 +0100
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <48285.22454.qm@web51005.mail.re2.yahoo.com>
References: <48285.22454.qm@web51005.mail.re2.yahoo.com>
Message-ID: <1267095523.2722.40.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mer, 2010-02-24 at 16:58 -0800, Fabio Estevam wrote:
> Add NAND support to MX31PDK board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com> 

Mmm.. maybe I waited too much before pull my work on this board..
Fabio, don't you think to change the namespace in mach-mx31_3ds
to accomplish to the new machine file name before adding some more 
functionality?

I am waiting for the rebase of mxc-master on 2.6.34-rc1 (or 
linux-next).

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
