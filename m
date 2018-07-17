From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 18 Jul 2018 01:28:31 +0530
Subject: [PATCH 4/5] thermal: exynos: fixed the efuse min/max value for
 exynos5422
In-Reply-To: <CAJKOXPfOiTARmtkcJeC49RicWOt8q98GKPJOQkYmqG_nJtY=aQ@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-4-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPfOiTARmtkcJeC49RicWOt8q98GKPJOQkYmqG_nJtY=aQ@mail.gmail.com>
Message-ID: <CANAwSgSwKBFDSWAF2dox9c7DAKKbHShXBNtSUcea2FdoR=80yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 17 July 2018 at 17:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> e-fuse range min~max range is 16~76. if e-fuse value is out of
>
> s/e-fuse/Fuse/
> s/if/If/
>
> Can you share the sources confirming that fuse values are between 16 and 76?
>
Below is my patch :
https://github.com/hardkernel/linux/commit/52c4c9b295930bc53b215d38e274aeb0780917f1

e-Fuse range min/max values are from exynos5422 user manual.

Best Regards
-Anand
