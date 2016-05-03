From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 03 May 2016 12:17:50 +0200
Subject: [PATCH 1/7] reset: add devm_reset_controller_register API
In-Reply-To: <1462099023-11819-2-git-send-email-yamada.masahiro@socionext.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
 <1462099023-11819-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462270670.3617.49.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

Am Sonntag, den 01.05.2016, 19:36 +0900 schrieb Masahiro Yamada:
> Add a device managed API for reset_controller_register().
> 
> This helps in reducing code in .remove callbacks and sometimes
> dropping .remove callbacks entirely.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thank you for these patches. Except for the issue with the lpc18xx patch
they all look good to me.
If you don't mind, I'll drop the lpc18xx patch for now and apply the
others.

regards
Philipp
