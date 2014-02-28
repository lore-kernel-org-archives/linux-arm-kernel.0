From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 28 Feb 2014 20:55:53 +0100
Subject: [PATCH 01/03] ARM: shmobile: Introduce shmobile_clk_workaround()
In-Reply-To: <20140224072930.3522.54629.sendpatchset@w520>
References: <20140224072921.3522.55023.sendpatchset@w520>
 <20140224072930.3522.54629.sendpatchset@w520>
Message-ID: <20140228195553.GA2517@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 04:29:30PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Introduce a new clock workaround function used by DT reference
> code on the mach-shmobile subarchitecture. The new function
> shmobile_clk_workaround() is used to configure clkdev to
> allow DT and platform devices to coexist. It is possible for
> the DT reference board code to also request enabling of the clock
> in case the driver does not implement clock control.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>
Tested-by: Wolfram Sang <wsa@sang-engineering.com>

I use it for r7s72100, too, meanwhile.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/821c79f8/attachment.sig>
