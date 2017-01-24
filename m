From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 24 Jan 2017 15:49:57 +0800
Subject: [PATCH v14 0/6] Enable PMUs in ACPI systems
In-Reply-To: <1485210765-9422-1-git-send-email-jeremy.linton@arm.com>
References: <1485210765-9422-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <cea38f4f-4696-baab-b539-f9d0a8db3f42@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/1/24 6:32, Jeremy Linton wrote:
> This patch expands and reworks the patches published by Mark Salter
> in order to clean up a few of the previous review comments, as well as
> add support for newer CPUs and big/little configurations.
>
> v14:
> - drop rename patch requested for v6
> - Shuffle couple include lines from one patch to a later
>   patch.

Test again on D03 and works fine as before,

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Hanjun
