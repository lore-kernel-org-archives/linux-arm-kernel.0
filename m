From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 27 Mar 2018 10:45:01 -0700
Subject: [PATCH v5 11/13] ARM: dts: ipq8074: Add peripheral nodes
In-Reply-To: <1521800336-19266-12-git-send-email-sricharan@codeaurora.org>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-12-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180327174501.GN1403@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> +		serial_blsp0: serial at 78af000 {

Please try to have a single scheme for how you name your labels; this is
serial0 or blsp1_uart1.

[..]
> +		i2c_0: i2c at 78b6000 {

As in the previous patches, this is the 2nd i2c master in the SoC,
please label it accordingly.

Regards,
Bjorn
