From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 18 Oct 2016 20:44:05 +0800
Subject: [PATCH V3 05/10] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <1475875882-2604-6-git-send-email-tbaicar@codeaurora.org>
References: <1475875882-2604-1-git-send-email-tbaicar@codeaurora.org>
 <1475875882-2604-6-git-send-email-tbaicar@codeaurora.org>
Message-ID: <496ddac3-a220-fd42-5ca1-3d0fb0238907@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On 2016/10/8 5:31, Tyler Baicar wrote:
> ARM APEI extension proposal added SEA (Synchrounous External
> Abort) notification type for ARMv8.
> Add a new GHES error source handling function for SEA. If an error
> source's notification type is SEA, then this function can be registered
> into the SEA exception handler. That way GHES will parse and report
> SEA exceptions when they occur.

Does this SEA is replayed by the firmware (firmware first handling)
or directly triggered by the hardware when error is happened?

Thanks
Hanjun
