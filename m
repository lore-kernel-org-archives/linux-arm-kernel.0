From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 19 May 2015 15:16:59 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: make savedefconfig for
 removinguseless configs
In-Reply-To: <5559902F.7040506@samsung.com>
References: <55598A56.7020006@kernel.org> <5559902F.7040506@samsung.com>
Message-ID: <555AD55B.2060405@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/15 16:09, Krzysztof Kozlowski wrote:
> On 18.05.2015 15:44, Kukjin Kim wrote:
>> This patch removes useless configs which can be seleted according to
>> the dependencies in defconfig with using 'make savedefconfig' because
>> we don't need to keep them in defconfig file.
>>
>> Signed-off-by: Kukjin Kim <kgene@kernel.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> ---
>> When I tried to sort out exynos related configs for multi_v7_defconfig,
>> I found there are many useless configs in there so sending this. If you
>> guys OK with this, I'll sort them out including this.
> 
> On which tree and commit this is rebased on? I tried next
> (next-20150515) and your for-next (v4.1-rc3-34-gfcfae6b049cf) branches
> but I does not apply to any of them. Can you point me to base branch?
> 
I've applied all of changes from you and Javier and it will be sent out
to arm-soc in a day. Please see the samsung-defconfig branch in my tree
and if any problems, let me know.

Thanks,
Kukjin
