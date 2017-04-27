From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Apr 2017 21:56:34 +0200
Subject: [PATCH V5 1/4] arm64: dts: Add basic DT to support Spreadtrum's
 SP9860G
In-Reply-To: <1492746440-11071-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <20170419142425.GB12105@localhost>
 <1492746440-11071-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <CAK8P3a1igaayFWFES85bJ4riFOHKhVURT3CRnAHKa1FkV6oQ-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 5:47 AM, Chunyan Zhang
<chunyan.zhang@spreadtrum.com> wrote:
> From: Orson Zhai <orson.zhai@spreadtrum.com>
>
> SC9860G is a 8 cores of A53 SoC with 4G LTE support SoC from Spreadtrum.
>
> According to regular hierarchy of sprd dts, whale2.dtsi contains SoC
> peripherals IP nodes, sc9860.dtsi contains stuff related to ARM core stuff
> and sp9860g dts is for the board level.
>
> Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Applied to next/dt64 now, thanks!

       Arnd
