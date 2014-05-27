From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 May 2014 09:46:18 -0700
Subject: [PATCH] ARM: at91/defconfig: sama5_defconfig: updated
In-Reply-To: <1401194721-22586-1-git-send-email-nicolas.ferre@atmel.com>
References: <1401194721-22586-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20140527164618.GA21482@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 02:45:21PM +0200, Nicolas Ferre wrote:
> From: Wenyou Yang <wenyou.yang@atmel.com>
> 
> due to enabling
> 	-- CONFIG_REGULATOR
> 	-- CONFIG_REGULATOR_ACT8865
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> [nicolas.ferre at atmel.com: move added entries to proper location within file]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi Arnd, Olof, Kevin,
> 
> I have this little patch lying around without other updates to AT91
> defconfig files so far. Is it possible to take this patch in arm-soc
> without a pull-request?

Certainly. Applied to next/defconfig.


-Olof
