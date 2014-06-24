From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 13:50:57 -0400 (EDT)
Subject: [PATCH 3/3] ARM: exynos: activate the CCI on boot CPU/cluster
 with the MCPM loopback
In-Reply-To: <CAD=FV=W2KK1XPQiHnxzdBs8fXxsnsuggZg_hJU0zyHcvHt3Khw@mail.gmail.com>
References: <1403583071-5650-1-git-send-email-nicolas.pitre@linaro.org>
 <1403583071-5650-4-git-send-email-nicolas.pitre@linaro.org>
 <CAD=FV=W2KK1XPQiHnxzdBs8fXxsnsuggZg_hJU0zyHcvHt3Khw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1406241347070.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jun 2014, Doug Anderson wrote:

> Thank you very much for posting!  With your series I'm able to boot
> all 8 cores on exynos5420-peach-pit and exynos5800-peach-pi sitting on
> my desk.
> 
> Tested-by: Doug Anderson <dianders@chromium.org>

Thanks to all.  I've submitted those patches, with minor nits fixed, to 
RMK's system as patches 8081 to 8083.


Nicolas
