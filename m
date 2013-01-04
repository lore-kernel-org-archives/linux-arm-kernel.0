From: vatsa@codeaurora.org (Srivatsa Vaddagiri)
Date: Fri, 4 Jan 2013 11:29:34 -0800
Subject: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line
 of /proc/stat" (commit 7386cdbf2f57ea8cff3c9fde93f206e58b9fe13f).
In-Reply-To: <50E6C776.7060707@mvista.com>
References: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
 <50E6C776.7060707@mvista.com>
Message-ID: <20130104192934.GB29866@quicinc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sergei Shtylyov <sshtylyov@mvista.com> [2013-01-04 16:13:42]:

> >With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
> >don't need the check for cpu_online() introduced in commit 7386cdbf. Offline
> 
>    Please also specify the summary of that commit in parens (or
> however you like).

I had that in Subject line, but yes would be good to include in commit message
as well. I will incorporate that change alongwith anything else required in
next version of this patch.

- vatsa
