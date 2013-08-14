From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Aug 2013 00:15:03 -0700
Subject: [GIT PULL] Samsung-fixes-2 for v3.11
In-Reply-To: <10a101ce98bd$c004bd20$400e3760$@org>
References: <51FFE30A.5040800@samsung.com> <87ob92pv1x.fsf@kernel.org>
 <10a101ce98bd$c004bd20$400e3760$@org>
Message-ID: <CAOesGMini9xy5AjVzQinvGS3c2eA9dcPYRJxKf0R0z84FUSHGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 12:13 AM, Kukjin Kim <kgene@kernel.org> wrote:
> Kevin Hilman wrote:
>>
>> Kukjin Kim <kgene.kim@samsung.com> writes:
>>
>> > The following changes since commit
>> 5ae90d8e467e625e447000cb4335c4db973b1095:
>> >
>> >   Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> > tags/samsung-fixes-2
>> >
>> > for you to fetch changes up to 35f8550c8f27968af94ba5235cc611e3b6d86981:
>> >
>> >   ARM: SAMSUNG: fix to support for missing cpu specific map_io
>> > (2013-07-30 13:30:57 +0900)
>>
>> In the future, please send arm-soc pull request to arm at kernel.org also,
>> this makes filtering easier when non-Arnd/Olof folks (like me) are
> helping.
>>
> OK, it's not difficult, BTW I'm not sure what the difference of
> linux-arm-kernel ml and arm(at)kernel.org.

arm at kernel.org goes to Arnd, Kevin, Russel and myself. I think there
might be one or two more people on there, but in general it's
arm-soc+arm maintainers.

We haven't wanted to add it to MAINTAINERS since we want to keep the
traffic mostly to the pull requests of platform maintainers, and not
as a cc of patch postings, to keep the traffic volume manageable. :)


-Olof
