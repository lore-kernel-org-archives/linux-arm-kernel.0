From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 20 Mar 2018 07:31:31 -0700
Subject: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
In-Reply-To: <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180320143131.4eenixtbhciq5fwc@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 09:28:47AM +0530, Sricharan R wrote:
> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> Adds missing memory, reserved-memory nodes.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 28 +++++++++++++++++++++++++++

Q: Does mainline Linux even boot on the DK?

A: No, it doesn't.

Please add the missing basic board support before hacking random stuff
into the DTS.

Thanks,
Richard
