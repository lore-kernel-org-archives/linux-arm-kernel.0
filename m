From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 Dec 2015 21:03:02 +0800
Subject: [PATCH v2] clk: imx5: ipu_di_sel clocks can set parent rates
In-Reply-To: <1449047797-4300-1-git-send-email-linux-kernel-dev@beckhoff.com>
References: <1449047797-4300-1-git-send-email-linux-kernel-dev@beckhoff.com>
Message-ID: <20151202130302.GV692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 10:16:37AM +0100, linux-kernel-dev at beckhoff.com wrote:
> From: Patrick Br?nn <p.bruenn@beckhoff.com>
> 
> To obtain exact pixel clocks, allow the DI clock selectors to influence
> the PLLs that they are derived from.
> 
> Commit 4591b13289b5 ("ARM: i.MX6: ipu_di_sel clocks can set parent
> rates") did this for i.MX6.
> Port it to enable high display resolutions on i.MX53 based platforms
> such as CX9020 Embedded PC, too.
> 
> Signed-off-by: Patrick Br?nn <p.bruenn@beckhoff.com>

Applied, thanks.
