From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 30 Mar 2016 11:37:30 +0200
Subject: [PATCH v3 3/8] clk: samsung: exynos3250: Add MMC2 clock
In-Reply-To: <56F9DEE6.8020203@samsung.com>
References: <1458027490-13787-1-git-send-email-cw00.choi@samsung.com>
 <1458027490-13787-4-git-send-email-cw00.choi@samsung.com>
 <56F47ABC.7060006@samsung.com> <56F509E6.7080807@samsung.com>
 <56F87E83.7060100@samsung.com> <56F9DEE6.8020203@samsung.com>
Message-ID: <56FB9E5A.1080507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2016 03:48 AM, Krzysztof Kozlowski wrote:
> On 28.03.2016 09:44, Chanwoo Choi wrote:
>> > You mean that separate patch1 include only the new clock id about both UART2 and MMC2
>> > and the patch2/patch3 just use the new clock id as following:
>> > 
>> > patch1 dt-bindings: Add the clock id of UART2 and MMC2 for Exynos3250
>> > patch2 clk: samsung: exynos3250: Add UART2 clock
>> > patch3 clk: samsung: exynos3250: Add MMC2 clock
>> > 
>> > As far as I understand it is that right?
>> > If it is ok, I'll modify it on v4 patchset as you comment.
>
> Hi Sylwester and Tomasz,
> 
> Can you provide me a tag with these exynos3250 clock patches (after
> posting v4)? Of course you can also ack/review them and then I'll handle it.

OK, I will provide a stable branch as soon as there is v4 available.

-- 
Regards,
Sylwester
