From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 27 Mar 2018 10:14:14 -0700
Subject: [PATCH v5 07/13] ARM: dts: ipq4019: Add
 qcom-ipq4019-ap.dk04.1-c3 board file
In-Reply-To: <1521800336-19266-8-git-send-email-sricharan@codeaurora.org>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-8-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180327171414.GJ1403@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C3";

Add a compatible to the board file.

Also, things like alias would make sense to put in the board unless
there's some restriction making every board having the same layout.

> +};

Regards,
Bjorn
