From: otavio@ossystems.com.br (Otavio Salvador)
Date: Wed, 4 Sep 2013 22:44:59 -0300
Subject: [PATCH v2 3/4] ARM: imx6sl: add imx6sl iomux-gpr field define
In-Reply-To: <1378182385-9205-4-git-send-email-B38611@freescale.com>
References: <1378182385-9205-1-git-send-email-B38611@freescale.com>
 <1378182385-9205-4-git-send-email-B38611@freescale.com>
Message-ID: <CAP9ODKqD05+S6HBnbBw-5Hs7NYVHRDJf014stSQ_AVeaYzVV+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 3, 2013 at 1:26 AM, Fugang Duan <B38611@freescale.com> wrote:
> Add imx6sl iomux-gpr register field define in "imx6q-iomuxc-gpr.h" header
> file, which is not fully define all iomux-gpr registers and fields, only
> add fec related macro define.
>
> Signed-off-by: Fugang Duan  <B38611@freescale.com>

The 'q' in the header filename is misleading; wouldn't be better to
have it named imx6-iomuxc-gpr.h than?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
