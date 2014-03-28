From: elder@linaro.org (Alex Elder)
Date: Fri, 28 Mar 2014 16:17:02 -0500
Subject: [RFC PATCH 0/7] ARM: SMP: common "pen" secondary release method
In-Reply-To: <1396041180-29897-1-git-send-email-elder@linaro.org>
References: <1396041180-29897-1-git-send-email-elder@linaro.org>
Message-ID: <5335E6CE.9030008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2014 04:12 PM, Alex Elder wrote:
> This series proposes creating a single implementation of the "pen
> release" (or spin-table) mechanism for starting secondary CPUs on

. . .

>   	
>   ARM: spear: use central SMP spin-table routines
>     This is straightforward as well, but it depends on the
>     two prerequisite patches mentioned above (which together
>     make this code roughly identical to the rest).

Here are the patches, which I neglected to mention after all:

    http://www.spinics.net/lists/arm-kernel/msg315833.html
    http://www.spinics.net/lists/arm-kernel/msg318735.html
