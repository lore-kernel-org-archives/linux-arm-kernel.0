From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 15 Nov 2012 13:46:17 +0400
Subject: [PATCH v3 2/6] ARM: davinci: Changed pr_warning() to pr_warn()
 (part 2)
In-Reply-To: <13514BD7FAEBA745BBD7D8A672905C14311F2D0E@DFLE08.ent.ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-2-git-send-email-rtivy@ti.com>
 <50A36FA9.5050601@mvista.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F2D0E@DFLE08.ent.ti.com>
Message-ID: <50A4B9E9.6000303@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 15-11-2012 5:53, Tivy, Robert wrote:

>>> Also, while modifying those pr_warning() calls I changed hardcoded
>>> function names to use '"%s:", __func__' instead

>>> Signed-off-by: Robert Tivy <rtivy@ti.com>
>>> ---
>>> Clean up files that will be otherwise modified in subsequent patch.

>>> Applies to v3.7-rc2 tag (commit
>>> 6f0c0580b70c89094b3422ba81118c7b959c7556) of Linus' mainline kernel
>> at git.kernel.org.

>>>    arch/arm/mach-davinci/board-omapl138-hawk.c |   30 ++++++++++------
>> -----------
>>>    1 file changed, 11 insertions(+), 19 deletions(-)

>>      Taksing of separation of board and SoC specific changes, this patch

    I meant "talking". :-/

>> shouldn't have been separated from patch 1 at all -- since it's two
>> boards built around the same chip, OMAP-L138...

> The 4 patches that are of the same nature ("Changed pr_warning() to pr_warn() (part #)") were split as 4 separate patches on request by Sekhar, for the purpose of making it easier to merge later.

    To quote Sekhar: "My main motivation was to keep board and soc file 
changes from mixing together." You just went too far.

WBR, Sergei
