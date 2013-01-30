From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 30 Jan 2013 21:02:00 +0800
Subject: [PATCH V3  0/5] W1: Support onewire master on i.MX53
In-Reply-To: <20130129154608.5184.46101.stgit@localhost>
References: <20130129154608.5184.46101.stgit@localhost>
Message-ID: <20130130130157.GB2757@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 04:46:08PM +0100, Martin Fuzzey wrote:
> W1: Support onewire master on i.MX53
> 	* Add device tree and pinctrl support to the MXC master driver
> 	* Convert to use devm_
> 	* Add i.MX53 clocks
> 	* Add i.MX53 device tree entries

Applied, thanks.

I changed the patch order a little bit, moving dts change to the last,
and also fix the patch subject prefix.

      W1: Add device tree support to MXC onewire master.
      W1: Convert MXC onewire master to devm_ functions.
      W1: Add pinctrl support to MXC onewire master.
      ARM: i.MX53: Add clocks for i.mx53 onewire master.
      ARM: dts: Add device tree entry for onewire master on i.MX53

One 'new blank line at EOF' warning on patch #1 gets fixed.

And please remember to add some commit log for patches you submit in
the future.  Empty commit log is not good.

Shawn
