From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Wed, 14 Sep 2016 14:48:20 +0200
Subject: [RESEND PATCH] arm64: kgdb: fix single stepping
In-Reply-To: <1429578793-3971-1-git-send-email-takahiro.akashi@linaro.org>
References: <1429578793-3971-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <ad132a20-2192-8b5d-8de9-d60d10c80f45@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

[snip]

> We can avoid this issue by specifying "nokgdbroundup" in kernel parameter,
> but this will also leave other cpus be in unknown state in terms of kgdb,
> and may result in interfering with kgdb activity.

> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org 
<http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>>

Tested-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

[snip]
