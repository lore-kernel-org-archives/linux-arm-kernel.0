From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 21 Nov 2016 11:17:31 +0100
Subject: [PATCH 1/6] ASoC: samsung: Remove non-existing MACH dependencies
In-Reply-To: <1479566911-5580-2-git-send-email-krzk@kernel.org>
References: <1479566911-5580-1-git-send-email-krzk@kernel.org>
 <CGME20161119144906epcas2p47ee345e38d6a7139536dabded337ab7f@epcas2p4.samsung.com>
 <1479566911-5580-2-git-send-email-krzk@kernel.org>
Message-ID: <d0d41d7a-31b3-d805-f7cb-3c0473382f2e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2016 03:48 PM, Krzysztof Kozlowski wrote:
> MACH_SMDKC100 was removed in commit b8529ec1c1b0 ("ARM: S5PC100: no more
> support S5PC100 SoC"). MACH_SMDKV210 and MACH_SMDKC110 in commit
> 28c8331d386 ("ARM: S5PV210: Remove support for board files").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
