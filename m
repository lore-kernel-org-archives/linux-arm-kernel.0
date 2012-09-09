From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 9 Sep 2012 18:15:04 +0000 (UTC)
Subject: OMAP baseline test results for v3.6-rc5
In-Reply-To: <alpine.DEB.2.00.1209091743430.28047@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209091743430.28047@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1209091814380.28047@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One other thing to mention:

On Sun, 9 Sep 2012, Paul Walmsley wrote:

> PM tests:
> 
> * 37xx EVM: CORE not entering dynamic off-idle
>   - Cause unknown; dynamic retention-idle seems to work; system suspend to 
>     off works
> 
> * 4430ES2 Panda: UART corruption during long transmit buffers
>   - Presumably due to either a missing hardware workaround or a bug in
>     the OMAP serial driver
> 
> * 4430ES2 Panda: CORE, L4PER, L3INIT, TESLA, IVAHD not going idle
>   - Cause unknown; may be partially due to McPDM reset problem

* 3730 Beagle XM: does not serial wake from off-idle suspend when console
  UART doesn't clock gate ("debug ignore_loglevel")
  - Not shown in the current test logs; cause unknown


- Paul
