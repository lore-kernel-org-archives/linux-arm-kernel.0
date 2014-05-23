From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 May 2014 00:16:55 -0700
Subject: [PATCH RESEND] mmc: dove: fix missing MACH_DOVE dependency
In-Reply-To: <CAPDyKFo8CdyDbJEP0GkFTHdzpkyRBZEp-jAyrU4y8qi__zChkA@mail.gmail.com>
References: <1400522571-10799-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CAPDyKFo8CdyDbJEP0GkFTHdzpkyRBZEp-jAyrU4y8qi__zChkA@mail.gmail.com>
Message-ID: <CAOesGMjyk=n7MyVisfjYze9UuEb7XNv5O+c1Tndc+q1Q=PEetQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 2:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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

Ulf, you might consider adding your tree to linux-next if this is
going to be a common work flow for you guys.

It's partially up to Chris though, if he's OK with patches going into
your branch more or less being guaranteed to make it into his as well.


-Olof
