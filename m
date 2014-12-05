From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 05 Dec 2014 14:02:52 +0100
Subject: [PATCH v4 1/3] clk: samsung: Fix clock disable failure because
 domain being gated
In-Reply-To: <5481A650.8020408@collabora.co.uk>
References: <1417777254-26579-1-git-send-email-k.kozlowski@samsung.com>
 <1417777254-26579-2-git-send-email-k.kozlowski@samsung.com>
 <5481955A.9000703@samsung.com> <5481A650.8020408@collabora.co.uk>
Message-ID: <5481ACFC.8000502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/14 13:34, Javier Martinez Canillas wrote:
> Hello Sylwester,
> 
> On 12/05/2014 12:22 PM, Sylwester Nawrocki wrote:
>>> >> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> > 
>> > Can you confirm sound works with this patch on exynos5420 ? Or does
>> > your Tested-by refer only to successful booting ?
>> > 
> I tested latest linux-next + "clk: samsung: Fix double add of syscore
> ops after driver rebind" [0] + this series and I confirm that sound is
> also working on my Exynos5420 Peach Pit Chromebook.

OK, thanks a lot for checking it again.

--
Regards,
Sylwester
