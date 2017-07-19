From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 19 Jul 2017 13:25:51 -0700
Subject: [PATCH 2/2] arm64: dts: move rpi into rpi directory
In-Reply-To: <87mv80dvpo.fsf@eliezer.anholt.net>
References: <1500483950-9217-1-git-send-email-scott.branden@broadcom.com>
 <1500483950-9217-3-git-send-email-scott.branden@broadcom.com>
 <87mv80dvpo.fsf@eliezer.anholt.net>
Message-ID: <ff694220-b771-4702-c9dc-536a3c87770e@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,


On 17-07-19 01:21 PM, Eric Anholt wrote:
> Scott Branden <scott.branden@broadcom.com> writes:
>
>> Place rpi into its own subdirectory.  This helps as the number
>> of Broadcom boards grow and we can separate them per SoC.
> It seems like pretty unnecessary churn to me, though I wouldn't
> necessarily block it.  However, it conflicts with the patch I was
> preparing yesterday to try to resolve our DT merging troubles
> (https://lkml.org/lkml/2017/5/16/707), so I'd like to hold off on it for
> now.
I'm quite fine with dropping the rpi dts patch.  I'm going to proceed 
with the northstar2 patch
before more SoC and boards are introduced.
Thanks,
  Scott
