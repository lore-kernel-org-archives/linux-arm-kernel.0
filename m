From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Nov 2015 13:16:20 -0200
Subject: [PATCH V2 06/11] mmc: sdhci-esdhc-imx: fix cd regression for dt
 platform
In-Reply-To: <CAOCHtYj1QuEYLg4vbxshWkYXPe6r9b5OP7hh_O0WoE6xfL0mjw@mail.gmail.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
 <1437569590-5228-7-git-send-email-aisheng.dong@freescale.com>
 <2333b5f060a8e45bd8adcdab55365fab@agner.ch>
 <CAOMZO5BUKmqczyVgz_WgYmBMeuGugDS4uVjw+LXebxf-nPDTyw@mail.gmail.com>
 <CAOMZO5Dz0KijjryoPihoXsP4b5Wy_5rock++oY=i-9gESThUbg@mail.gmail.com>
 <CAOCHtYgayRZoHxJ2d8f1mO0QW_=N4Mx2_RSCrADKERHdP9TGYQ@mail.gmail.com>
 <CAOMZO5D2LNS93XVx86fL7oLTgy4apU036v-ohhv-=kw5gFsCww@mail.gmail.com>
 <CAOCHtYj1QuEYLg4vbxshWkYXPe6r9b5OP7hh_O0WoE6xfL0mjw@mail.gmail.com>
Message-ID: <CAOMZO5CJsRoXpsV2e0WTzKWmQJxvb45DVOAUeUGH_Oro_svfQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Sun, Oct 25, 2015 at 7:33 PM, Robert Nelson <robertcnelson@gmail.com> wrote:

> Thanks Fabio, that fixes the regression on v4.1.11 on my wand's... Too
> bad it's also not in:
>
> https://lkml.org/lkml/2015/10/23/516

The fix is in 4.1.13 now.
