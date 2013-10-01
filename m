From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Tue, 01 Oct 2013 15:49:23 +0200
Subject: [PATCH] PCI: exynos: missing clk_disable_unprepare() on error
 in exynos_pcie_probe()
In-Reply-To: <000301cebe46$42e86e00$c8b94a00$%han@samsung.com>
References: <CAPgLHd_RTNxi-OYhmTZ35NttjnAg-gQ_WKHkUQr5ueMhXVLTMg@mail.gmail.com>
 <000301cebe46$42e86e00$c8b94a00$%han@samsung.com>
Message-ID: <524AD2E3.9010808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 03:33 AM, Jingoo Han wrote:
> On Sunday, September 29, 2013 11:29 AM, Wei Yongjun wrote:
>>
>> From: Wei Yongjun<yongjun_wei@trendmicro.com.cn>
>>
>> Add the missing clk_disable_unprepare() before return
>> from exynos_pcie_probe() in the error handling case.
>>
>> Signed-off-by: Wei Yongjun<yongjun_wei@trendmicro.com.cn>
>
> Acked-by: Jingoo Han<jg1.han@samsung.com>
>
> However, the commit name should be fixed as below:
> [PATCH] PCI: exynos: use missing clk_disable_unprepare() on error in exynos_pcie_probe()

Perhaps just:

"PCI: exynos: Add missing clk_disable_unprepare() on error path

How can something that is missing be used ? :)
