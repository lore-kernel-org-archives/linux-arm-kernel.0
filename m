From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 19 Dec 2013 15:03:10 -0800
Subject: [GIT PULL 1/3] ARM: keystone: device tree updates for 3.14
In-Reply-To: <1387230397-14338-1-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 16 Dec 2013 16:46:35 -0500")
References: <1387230397-14338-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <8761qkjvf5.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Arnd, Olof, Kevin,
>
> Please pull below keystone device tree updates for 3.14
>
> Regards,
> Santosh
>
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts
>
> for you to fetch changes up to 732079567da4942b7b4929deff8f236926d0b3eb:
>
>   ARM: dts: keystone: Add usb devicetree bindings (2013-12-12 20:29:17 -0500)
>
> ----------------------------------------------------------------
> Keystone DTS updates for 3.14
>
> - ddr3 pll clock node typo fixup.
> - EVM specific clock setting with board k2hk-evm.dts.
> - GIC node updates for missing virtualisation info.
> - Adding USB dwc3 and phy nodes.
>
> ----------------------------------------------------------------
> Murali Karicheri (3):
>       ARM: keystone: dts: add a k2hk-evm specific dts file
>       ARM: keystone: dts: fix typo in the ddr3 pllclk node name
>       ARM: keystone: dts: add paclk divider clock node
>
> Santosh Shilimkar (2):
>       ARM: dts: keystone: Add the GICV and GICH address space
>       ARM: dts: keystone: Add guestos maintenance interrupt
>
> WingMan Kwok (2):
>       ARM: dts: keystone: Add usb phy devicetree bindings
>       ARM: dts: keystone: Add usb devicetree bindings

I'm not willing to pull these new bindings.

These new bindings don't have an ack from DT maintainers, and from a
quick scan of the archives, don't appear to have ever been posted to the
DT list.  If they had been posted to the DT list, and hadn't had a
response after 2 weeks, it would've been OK for you to queue them up for
us, but as it stands they haven't even been posted for the attention of
the DT maintainers.  Please remedy that.  Thanks.

Kevin
