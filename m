From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 01 Apr 2016 09:15:20 +0900
Subject: [PATCH v3 3/8] clk: samsung: exynos3250: Add MMC2 clock
In-Reply-To: <56FD045B.5020805@samsung.com>
References: <1458027490-13787-1-git-send-email-cw00.choi@samsung.com>
 <1458027490-13787-4-git-send-email-cw00.choi@samsung.com>
 <56F47ABC.7060006@samsung.com> <56F509E6.7080807@samsung.com>
 <56F87E83.7060100@samsung.com> <56F9DEE6.8020203@samsung.com>
 <56FD045B.5020805@samsung.com>
Message-ID: <56FDBD98.30406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.03.2016 20:04, Sylwester Nawrocki wrote:
> On 03/29/2016 03:48 AM, Krzysztof Kozlowski wrote:
>> On 28.03.2016 09:44, Chanwoo Choi wrote:
>>> You mean that separate patch1 include only the new clock id 
>>> about both UART2 and MMC2
>>> and the patch2/patch3 just use the new clock id as following:
>>>
>>> patch1 dt-bindings: Add the clock id of UART2 and MMC2 for Exynos3250
>>> patch2 clk: samsung: exynos3250: Add UART2 clock
>>> patch3 clk: samsung: exynos3250: Add MMC2 clock
>>>
>>> As far as I understand it is that right?
>>> If it is ok, I'll modify it on v4 patchset as you comment.
>>
>> Hi Sylwester and Tomasz,
>>
>> Can you provide me a tag with these exynos3250 clock patches (after
>> posting v4)? Of course you can also ack/review them and then I'll 
>> handle it.
> 
> Here are tags with only the first (clock id definitions) and the all 
> three clk patches respectively:
> 
> ---------------------------------------8<--------------------------------
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://linuxtv.org/snawrocki/samsung.git tags/clk-v4.7-exynos3250-dt
> 
> for you to fetch changes up to fd00bbcddb59c4866e7c985e30f663b62cfc2588:
> 
>   dt-bindings: Add the clock id of UART2 and MMC2 for Exynos3250 (2016-03-31 12:25:44 +0200)
> 
> ----------------------------------------------------------------
> Addition of the UART2 and MMC3 clock indices definition
> to the exynos3250 clock subsystem dt binding header file.
> 
> ----------------------------------------------------------------
> Chanwoo Choi (1):
>       dt-bindings: Add the clock id of UART2 and MMC2 for Exynos3250
> 
>  include/dt-bindings/clock/exynos3250.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> --------------------------------------->8--------------------------------
> 
> 
> ---------------------------------------8<--------------------------------
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://linuxtv.org/snawrocki/samsung.git tags/clk-v4.7-exynos3250

Thanks pulled.

Krzysztof
