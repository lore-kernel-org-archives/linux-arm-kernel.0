From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 04 Jan 2013 16:13:42 +0400
Subject: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line
 of /proc/stat" (commit 7386cdbf2f57ea8cff3c9fde93f206e58b9fe13f).
In-Reply-To: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
References: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
Message-ID: <50E6C776.7060707@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-01-2013 6:58, Srivatsa Vaddagiri wrote:

> With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
> don't need the check for cpu_online() introduced in commit 7386cdbf. Offline

    Please also specify the summary of that commit in parens (or however you 
like).

> cpu's idle time as last recorded in its ts->idle_sleeptime will be reported
> (thus excluding its offline time as part of idle time statistics).

> Cc: mhocko at suse.cz
> Cc: srivatsa.bhat at linux.vnet.ibm.com
> Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>

WBR, Sergei
