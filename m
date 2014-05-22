From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 22 May 2014 15:04:07 +0200
Subject: [PATCH RESEND] mmc: dove: fix missing MACH_DOVE dependency
In-Reply-To: <CAPDyKFo8CdyDbJEP0GkFTHdzpkyRBZEp-jAyrU4y8qi__zChkA@mail.gmail.com>
References: <1400522571-10799-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CAPDyKFo8CdyDbJEP0GkFTHdzpkyRBZEp-jAyrU4y8qi__zChkA@mail.gmail.com>
Message-ID: <537DF5C7.3010009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2014 11:09 AM, Ulf Hansson wrote:
> On 19 May 2014 20:02, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
>> DT-enabled Dove moved over from ARCH_DOVE in mach-dove to MACH_DOVE in
>> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
>> DT-only MACH_DOVE Kconfig. This slipped through the cracks and now is
>> a fix to allow to build Dove's SDHCI driver for mach-mvebu on v3.15-rc.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>
> Thanks! Picked up for the PR I send to Chris.

Ulf, thanks for picking it up. I noticed it will now end up in v3.16
and not as a fix for v3.15. I'll come back to it, if v3.15 will
ever become a stable version ;)

Anyway, great you are helping Chris to pre-select the mmc patches!

Sebastian
