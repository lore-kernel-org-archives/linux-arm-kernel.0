From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jun 2016 08:24:12 +0200
Subject: [PATCH] ARM: exynos: fix UART address selection for DEBUG_LL
In-Reply-To: <54BCAA73.5080404@samsung.com>
References: <1411728234-29705-1-git-send-email-jy0922.shim@samsung.com>
 <54BCAA73.5080404@samsung.com>
Message-ID: <CAJKOXPeH_OU1NcHQpXXrnVL+_+RiG5win_k+a0JfWp2Mb3Xh0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 7:55 AM, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
> Hi kukjin,
>
> On 09/26/2014 07:43 PM, Joonyoung Shim wrote:
>> The exynos5 SoCs using A15+A7 can boot to A15 or A7. If it boots using
>> A7, it can't detect right UART physical address only the part number of
>> CP15. It's possible to solve as checking Cluster ID additionally.
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> ---
>>  arch/arm/include/debug/exynos.S | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>

This is an old patch... but still valid and needed on Odroid XU
family. Tested by Marek Szyprowski.

Applied, thanks!

BR,
Krzysztof
