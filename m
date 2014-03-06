From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Mar 2014 09:55:29 +0800
Subject: [PATCH v2] ARM: vf610: add UART choice for low-level debug
In-Reply-To: <4031771265d98dad7b0cc15a1e523f026338b432.1394057216.git.stefan@agner.ch>
References: <4031771265d98dad7b0cc15a1e523f026338b432.1394057216.git.stefan@agner.ch>
Message-ID: <20140306015525.GB11366@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 11:07:48PM +0100, Stefan Agner wrote:
> Add choice for low-level debug UART. Similar to i.MX6, there is a
> numeric configuration, valid choices are 0 to 3.
> Note that the kernel assumes that the boot loader initialized clock
> properly.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
