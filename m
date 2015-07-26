From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Jul 2015 21:39:50 +0200
Subject: [PATCH] ARM: appropriate __init annotation for const data
In-Reply-To: <alpine.LFD.2.20.1507241440550.1806@knanqh.ubzr>
References: <alpine.LFD.2.20.1507241440550.1806@knanqh.ubzr>
Message-ID: <20150726193950.GA494@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 02:54:04PM -0400, Nicolas Pitre wrote:
> 
> Init data marked const should be annotated with __initconst for
> correctness and not __initdata.  This also fixes LTO builds that
> otherwise fails with section mismatch errors.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Applied, thanks.


-Olof
