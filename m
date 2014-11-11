From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Nov 2014 18:23:59 -0800
Subject: [PATCH] tty: serial: msm_serial: Use DT aliases
In-Reply-To: <54617251.10306@gmail.com>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org>
 <545C4E1F.4060401@gmail.com> <54617251.10306@gmail.com>
Message-ID: <5461733F.4040402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2014 06:20 PM, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@sonymobile.com>
>
> v2, changes from v1:
>   - The patch this documents was updated to make the serialN alias
>     optional instead of required.

Not sure we want this v2 vs v1 part, but

>
> Update devicetree binding for msm_serial to reflect msm_serial_probe()
> getting line id from the serial alias.
>
> Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
