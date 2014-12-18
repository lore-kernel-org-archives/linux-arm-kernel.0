From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Thu, 18 Dec 2014 14:01:29 -0600
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54933299.9030902@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2014 8:37 AM, Hanjun Guo wrote:

> From: Graeme Gregory <graeme.gregory@linaro.org>
>
> Add documentation for the guidelines of how to use ACPI
> on ARM64.
>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>   Documentation/arm64/arm-acpi.txt |  323
> ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 323 insertions(+)
>   create mode 100644 Documentation/arm64/arm-acpi.txt
>[...]

AMD has reviewed this document, and currently implements ACPI table in 
the firmware for AMD Seattle platform based on the documentation 
published here:

http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2012/10/Seattle_ACPI_Guide.pdf

Reviewed-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Thank you,

Suravee
