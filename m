From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 24 Jan 2011 16:09:23 -0800
Subject: [PATCH v2 01/11] msm: Add CPU queries
In-Reply-To: <1295468747-22796-2-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-2-git-send-email-davidb@codeaurora.org>
Message-ID: <1295914163.29639.77.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-19 at 12:25 -0800, David Brown wrote:
> +#define cpu_is_msm7x01()       0
> +#define cpu_is_msm7x30()       0
> +#define cpu_is_qsd8x50()       0
> +#define cpu_is_msm8x60()       0

Now that I look at this again, why not drop the "x" all together ?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
