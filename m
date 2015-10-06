From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 16:36:03 +0200
Subject: [PATCH v2] arm64: dts: add all hi6220 uart nodes
In-Reply-To: <1443662388-25686-1-git-send-email-tyler.baker@linaro.org>
References: <1443662388-25686-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <13756810.CXgbUlyXY5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 September 2015 18:19:48 Tyler Baker wrote:
> This patch adds all UART nodes for the Hi6220 SoC. Recently a board[1] has
> been developed to standardize UART access across all the 96boards consumer
> edition boards. To use this hardware on HiKey we must configure and enable
> UART3. However, to ensure backward compatibility we must keep UART0 enabled
> as well.
> 
> I have removed the hard coded clock index values in favor of using the ones
> already defined in include/dt-bindings/clock/hi6220-clock.h.
> 
> Since UART0 needs to be soldered, it has been suggested to use the UART3 as
> the default console.
> 
> This patch was boot tested on top of next-20150930, with both UART
> configurations.
> 
> [1] http://www.seeedstudio.com/depot/96Boards-UART-p-2525.html?ref=newInBazaar
> 
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> 

Applied to next/dt, thanks!

	Arnd
