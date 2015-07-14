From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 14 Jul 2015 15:28:34 +0900
Subject: [PATCHv6] ARM: dts: add exynos5422-cpus.dtsi to correct cpu order
In-Reply-To: <CAGc3s_fQmWR_LNz-jbRDdGb3B8g0d+gSQa2=p_0k7yfJUD0PvA@mail.gmail.com>
References: <1436833441-8405-1-git-send-email-parkch98@gmail.com>
 <55A45C63.2030907@samsung.com> <06b101d0bdf2$8aad8fb0$a008af10$@kernel.org>
 <CAGc3s_fQmWR_LNz-jbRDdGb3B8g0d+gSQa2=p_0k7yfJUD0PvA@mail.gmail.com>
Message-ID: <55A4AC12.1090205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.07.2015 14:36, Mauro Ribeiro wrote:
> In my opinion since its something configurable by the board and not
> SoC specific it should be defined (or re-defined) on the board dts.
> 
> If one makes a 5422 board booting from A15's that patch will be
> already invalid and causing the issue that it fixes.

Indeed this is configurable by the board. For Odroid XU3 this is fixed
(hard-wired) but other boards may have it in different way. We already
discussed this and Chanho Park is here:
http://www.spinics.net/lists/linux-samsung-soc/msg44924.html
http://www.spinics.net/lists/linux-samsung-soc/msg44930.html

There were no additional objections to the patchset in that time.

Best regards,
Krzysztof
