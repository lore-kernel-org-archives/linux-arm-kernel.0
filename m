From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Oct 2012 09:16:07 +0000
Subject: [PATCH 6/6] mfd: Differentiate between u8500 and u9540 TCDM
 address mapping
In-Reply-To: <20121011085951.GU9707@gmail.com>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
 <201210101834.40749.arnd@arndb.de> <20121011085951.GU9707@gmail.com>
Message-ID: <201210110916.08159.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 October 2012, Lee Jones wrote:
> From what I understand, this code has to be called before Device
> Tree kicks in. Actually, this code is mearly a stand-in until Loic
> has finished with the PRCMU re-vamp. Once that's complete, this
> stuff will be passed from init_IRQ(), which is invoked directly in
> start_kernel().

Ok, fair enough.

	Arnd
