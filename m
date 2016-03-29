From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 29 Mar 2016 10:48:22 +0900
Subject: [PATCH v3 3/8] clk: samsung: exynos3250: Add MMC2 clock
In-Reply-To: <56F87E83.7060100@samsung.com>
References: <1458027490-13787-1-git-send-email-cw00.choi@samsung.com>
 <1458027490-13787-4-git-send-email-cw00.choi@samsung.com>
 <56F47ABC.7060006@samsung.com> <56F509E6.7080807@samsung.com>
 <56F87E83.7060100@samsung.com>
Message-ID: <56F9DEE6.8020203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.03.2016 09:44, Chanwoo Choi wrote:
> You mean that separate patch1 include only the new clock id about both UART2 and MMC2
> and the patch2/patch3 just use the new clock id as following:
> 
> patch1 dt-bindings: Add the clock id of UART2 and MMC2 for Exynos3250
> patch2 clk: samsung: exynos3250: Add UART2 clock
> patch3 clk: samsung: exynos3250: Add MMC2 clock
> 
> As far as I understand it is that right?
> If it is ok, I'll modify it on v4 patchset as you comment.

Hi Sylwester and Tomasz,

Can you provide me a tag with these exynos3250 clock patches (after
posting v4)? Of course you can also ack/review them and then I'll handle it.

BR,
Krzysztof
