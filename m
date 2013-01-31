From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Jan 2013 16:30:53 +0800
Subject: [PATCH 1/2] ARM i.MX6: Add regulator delay support
In-Reply-To: <1359585224-11304-1-git-send-email-b20788@freescale.com>
References: <1359585224-11304-1-git-send-email-b20788@freescale.com>
Message-ID: <20130131083050.GA2735@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 05:33:44PM -0500, Anson Huang wrote:
> For ANATOP LDOs, vddcpu, vddsoc and vddpu
> have step time settings in the misc2 register, need
> to add necessary step time info for these three LDOs,
> then regulator driver can add necessary delay based on
> these settings.
> 
> offset 0x170:
> bit [24-25]: vddcpu
> bit [26-27]: vddpu
> bit [28-29]: vddsoc
> 
> field definition:
> 0'b00: 64 cycles of 24M clock;
> 0'b01: 128 cycles of 24M clock;
> 0'b02: 256 cycles of 24M clock;
> 0'b03: 512 cycles of 24M clock;
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
