From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Oct 2016 21:44:56 +0300
Subject: [PATCH v2] ARM: shmobile: Consolidate R8A7743 and R8A779[234]
 machine definitions
In-Reply-To: <20161020085804.GK4612@verge.net.au>
References: <1476712744-32619-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20161020085804.GK4612@verge.net.au>
Message-ID: <4b407584-21d4-5dc7-6866-6feff12f302f@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/20/2016 11:58 AM, Simon Horman wrote:

>> The four SoCs use identical machine operations, consolidate them into
>> two machine definitions in a single file.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> Tested-by: Simon Horman <horms+renesas@verge.net.au>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Changes since v1:
>>
>> - Rebased on top of Simon's latest devel branch, thus including R8A7743
>>   consolidation
>>
>>  arch/arm/mach-shmobile/Makefile          |  4 ----
>>  arch/arm/mach-shmobile/setup-r8a7743.c   | 34 -------------------------------
>>  arch/arm/mach-shmobile/setup-r8a7792.c   | 35 --------------------------------
>>  arch/arm/mach-shmobile/setup-r8a7793.c   | 33 ------------------------------
>>  arch/arm/mach-shmobile/setup-r8a7794.c   | 33 ------------------------------
>>  arch/arm/mach-shmobile/setup-rcar-gen2.c | 33 ++++++++++++++++++++++++++++++
>>  6 files changed, 33 insertions(+), 139 deletions(-)
>>  delete mode 100644 arch/arm/mach-shmobile/setup-r8a7743.c
>>  delete mode 100644 arch/arm/mach-shmobile/setup-r8a7792.c
>>  delete mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
>>  delete mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
>
> Thanks for this Laurent, its a very nice diffstat.
> I have queued it up for v4.10.

    I'm not seeing a new devel tag when fetching... :-(

MBR, Sergei
