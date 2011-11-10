From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Nov 2011 10:20:57 +0100
Subject: [PATCH] Proposed patch for USB and RS485 on imx board
In-Reply-To: <1320915998.92232.YahooMailNeo@web28513.mail.ukl.yahoo.com>
References: <1320915998.92232.YahooMailNeo@web28513.mail.ukl.yahoo.com>
Message-ID: <20111110092057.GA2503@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

thanks for your submission.

>    Attached are two patches :?

Please inline them in the future, that makes reviewing much easier. See
Documentation/SubmittingPatches

>    - imx_rs485_support.patch : Implement the RS485 on imx board... like

This should have been sent to the linux-serial list, but it won't get
accepted. There will only be mainline support for _hardware based_
direction switching; emulating this in software will not guarantee
timings, see http://article.gmane.org/gmane.linux.serial/3619/

>    - imx_solve_compilation_problem_with_mx27.patch : Solve a compilation
>    problem when using host USB port with mx27 boards

See again SubmittingPatches, your Signed-off-by line is missing. And it
should go to the USB-list (with this one CCed, that's okay).

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111110/52d198d2/attachment.sig>
