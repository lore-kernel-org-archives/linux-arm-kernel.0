From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 05 Aug 2011 14:57:56 +0400
Subject: [PATCH] cpuidle: Consistent spelling of cpuidle_idle_call()
In-Reply-To: <1312475071-22973-1-git-send-email-davidb@codeaurora.org>
References: <1312475071-22973-1-git-send-email-davidb@codeaurora.org>
Message-ID: <4E3BCCB4.7060208@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-08-2011 20:24, David Brown wrote:

> Commit a0bfa1373859e9d11dc92561a8667588803e42d8 mispells

    Please also specify that commit's summary in parens.

> cpuidle_idle_call() on ARM and SH code.  Fix this to be consistent.

> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: x86 at kernel.org
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: David Brown<davidb@codeaurora.org>

WBR, Sergei
