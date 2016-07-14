From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 16:01:50 +0200
Subject: [GIT PULL] STi late updates for v4.8
In-Reply-To: <5784F935.9050000@st.com>
References: <5784F935.9050000@st.com>
Message-ID: <36203387.0bf4mZW6Q8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 12, 2016 4:05:41 PM CEST Patrice Chotard wrote:
> Highlights:
> -----------
> - Add STi DT critical clocks declaration
> - Remove SPI hack wich has dependecy with critical clocks
> 
> These 2 STi DT patches and SPI hack MUST be applied after patches
> contained into Stephen Boyd's branch clk-next/clk-st-critical.
> This to ensure not to break SPI.
> 

Merged into next/late now, thanks!

	Arnd
