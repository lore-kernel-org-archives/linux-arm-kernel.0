From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 2 Jun 2015 15:43:25 +0800
Subject: [PATCH v2 0/6] Introduce Allwinner A33 support
In-Reply-To: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v64Nm8jp+xEoUyPKV7UuhUXW3HS87hbp68MZAdrHR4uNgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 30, 2015 at 10:55 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Maxime,
>
> Here is a cleaned up series of Vishnu Patekar's A33 support. This should
> address all concerns raised during the posting of v1.
>
> I've tested that all peripherals declared in the shared sun8i-a23-a33.dtsi
> work on the A33 too, with the exception of the dma-controller. For the
> dma-controller I've compared the A23 vs A33 manual and the entire dma-
> controller description including the register description is bit for bit
> identical.
>
> This has been tested on a 7" Ippo Q8H v1.2 A23 tablet, a 7" Ippo Q8H v1.2
> A33 tablet and a 10" GA10H A33 tablet. The dts for the 10" tablet still
> needs some work wrt the lradc button voltages so that is not included
> in this set.

Whole series is

Tested-by: Chen-Yu Tsai <wens@csie.org>

on my Sinlinx SinA33 dev board. I'll send patches for it later.
