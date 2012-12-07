From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 6 Dec 2012 23:04:12 -0800
Subject: [PATCH 6/6 v9] cpufreq, highbank: add support for highbank cpufreq
In-Reply-To: <1354833773-22845-7-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354833773-22845-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354833773-22845-7-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <CAPtuhTi3Gvb0CQFiAe_bNRQ4k0xfzN9amQvwTeUsaJ7HLJsNHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 6, 2012 at 2:42 PM, Mark Langsdorf
<mark.langsdorf@calxeda.com> wrote:
> Highbank processors depend on the external ECME to perform voltage
> management based on a requested frequency. Communication between the
> A9 cores and the ECME happens over the pl320 IPC channel.
>
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: mturquette at linaro.org

Looks good to me.

Reviewed-by: Mike Turquette <mturquette@linaro.org>

Regards,
Mike
