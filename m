From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 4 Sep 2011 10:53:01 +0100
Subject: [PATCH] arm: exynos4: fix incorrect pad configuration for
	keypad row lines
In-Reply-To: <1315129244-26489-1-git-send-email-thomas.abraham@linaro.org>
References: <1315129244-26489-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20110904105301.01b82323@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> SMDKV310 board does not have pull-up resistors populated for the keypad
> row lines (unlike the smdk boards for the previous Samsung SoC's). So
> the pad pull-up for all keypad row lines should be enabled for
> smdkv310 board.

So does this change the behaviour of existing boards, and if so isn't it
the SMDKV310 that hould be providing the alternate gpio configuration
function ?
