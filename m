From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri, 29 Jan 2016 15:35:21 -0800
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <1454107764-19876-1-git-send-email-stefan@agner.ch>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
Message-ID: <20160129153521.3deee49c@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jan 2016 14:49:23 -0800
Stefan Agner <stefan@agner.ch> wrote:

> If a clock gets enabled early during boot time, it can lead to a PLL
> startup. The wait_lock function makes sure that the PLL is really
> stareted up before it gets used. However, the function sleeps which
s/stareted/started/
