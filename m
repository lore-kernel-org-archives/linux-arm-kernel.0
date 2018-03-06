From: gaku.inami.xh@renesas.com (Gaku Inami)
Date: Tue, 6 Mar 2018 05:11:33 +0000
Subject: [PATCH 5/5] soc: renesas: rcar-topology: Add support to be aware
 cpu capacity
In-Reply-To: <CAMuHMdVZzCOqatGA4PH0Gr+noTEhQ8RAW=pK5K1e7KrAM8VS-A@mail.gmail.com>
References: <1519697995-6061-1-git-send-email-gaku.inami.xh@renesas.com>
 <1519697995-6061-6-git-send-email-gaku.inami.xh@renesas.com>
 <CAMuHMdVZzCOqatGA4PH0Gr+noTEhQ8RAW=pK5K1e7KrAM8VS-A@mail.gmail.com>
Message-ID: <OSBPR01MB180009CEB4121AD9859EE36AA2D90@OSBPR01MB1800.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert-san,

> -----Original Message-----
> From: geert.uytterhoeven at gmail.com [mailto:geert.uytterhoeven at gmail.com] On Behalf Of Geert Uytterhoeven

[snip]

> None of the above seems R-Car specific to me. So please explain why this
> can't just be added to arch/arm64/kernel/topology.c instead, and enabled
> unconditionally.

Thanks for your feedback.

As you said, this code should not be R-Car specific. I will consider again
that it enables SD_ASYM_CPUCAPACITY unconditionally.

Regards,
Inami
