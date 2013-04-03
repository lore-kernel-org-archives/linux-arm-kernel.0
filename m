From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 Apr 2013 00:18:53 -0300
Subject: [PATCH] ARM: imx: do not bring up unavailable cores
In-Reply-To: <20130403024719.GF27148@S2101-09.ap.freescale.net>
References: <1364913146-26084-1-git-send-email-shawn.guo@linaro.org>
 <20130402151715.GB6608@mudshark.cambridge.arm.com>
 <20130403021348.GK24039@S2101-09.ap.freescale.net>
 <CAOMZO5AJjz4Z68GxkeCM3rH9p9-z6jaOM35MBSjN-UE_Dk4=eg@mail.gmail.com>
 <20130403024719.GF27148@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5C5uVDWi1vXTeyQF5P8N=ARHvW-qMknVeyG4zY85KcEkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 11:47 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Ah, great.  I haven't checked the U-Boot code for some time.  But does
> U-Boot remove cpu nodes of those unavailable cores from device tree
> before passing it to kernel?

No, it just uses the information from the SCU to print the name of the
mx6 variant on boot.
