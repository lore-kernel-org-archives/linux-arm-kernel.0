From: balbi@ti.com (Felipe Balbi)
Date: Mon, 10 Sep 2012 08:51:20 +0300
Subject: OMAP baseline test results for v3.6-rc5
In-Reply-To: <alpine.DEB.2.00.1209091814380.28047@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209091743430.28047@utopia.booyaka.com>
 <alpine.DEB.2.00.1209091814380.28047@utopia.booyaka.com>
Message-ID: <20120910055118.GA19264@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Sep 09, 2012 at 06:15:04PM +0000, Paul Walmsley wrote:
> > * 4430ES2 Panda: UART corruption during long transmit buffers
> >   - Presumably due to either a missing hardware workaround or a bug in
> >     the OMAP serial driver
> > 
> * 3730 Beagle XM: does not serial wake from off-idle suspend when console
>   UART doesn't clock gate ("debug ignore_loglevel")
>   - Not shown in the current test logs; cause unknown

How do you trigger these two ? Can you share whatever script you wrote
for this to fail ? I'm assuming the bugs are only triggered on those two
particular platforms, so it could just be missing workaround on both
cases (?)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120910/32579fea/attachment.sig>
