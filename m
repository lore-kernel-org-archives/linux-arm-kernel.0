From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 20 Jun 2017 08:34:39 +0200
Subject: [PATCH V17 00/11] Add UEFI 2.6 and ACPI 6.1 updates for RAS on
 ARM64
In-Reply-To: <20170607115012.GZ30263@arm.com>
References: <1495225933-4410-1-git-send-email-tbaicar@codeaurora.org>
 <20170607115012.GZ30263@arm.com>
Message-ID: <20170620063439.GS658@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On 07.06.17 12:50:12, Will Deacon wrote:

> Thanks, I've pushed this out as:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/ras-apei
>
> which I'll merge into for-next/core (and therefore linux-next) either the
> end of this week or the beginning of next week. Please take a look if you
> get a chance.

any reason why there was a roll back of for-next/core?

 + 0870f692c2ed...e27c7fa015d6 for-next/core -> arm64/for-next/core  (forced update)

Is it because for-next/ras-apei goes through tip?

Thanks,

-Robert
