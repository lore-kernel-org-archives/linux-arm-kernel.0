From: bryan.wu@canonical.com (Bryan Wu)
Date: Sat, 11 Aug 2012 22:23:20 +0800
Subject: [GIT PULL] LED CPU trigger driver and ARM LED code consolidation
 (v2)
In-Reply-To: <20120811080429.GA18957@n2100.arm.linux.org.uk>
References: <CAK5ve-KjK2mU0qjdp2HK5CdrM=eQ-hN0nw-0cJj7HGuRyGjH8w@mail.gmail.com>
 <CAK5ve-+wWWARGz4ky_VW2AK7hHLXENkw2ANToLztcDjsegubsw@mail.gmail.com>
 <CAOesGMhK3bkk+86jDM7bd6rFUE_RuTGWiWsB7SYJ=i2NocOiLA@mail.gmail.com>
 <CAK5ve-KuB=5evdiJDSQbN0N=56fofNeaof==GuRXFWhA44KcAw@mail.gmail.com>
 <CAOesGMi8UeX8fLba4F+Jo0VNadcBHbUsnc0HHA=SNx0S7=EFJw@mail.gmail.com>
 <CAK5ve-+hFRkbZ1bmfKodzjZEyP8vTyxZzU96LnhYjp1Vn7OWcw@mail.gmail.com>
 <20120811080429.GA18957@n2100.arm.linux.org.uk>
Message-ID: <CAK5ve-LX_q154+BYxzns38yAZ9BcLxsA26negXo9K4XMNxcrWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 4:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Aug 11, 2012 at 02:57:18PM +0800, Bryan Wu wrote:
>> On Wed, Aug 1, 2012 at 1:10 PM, Olof Johansson <olof@lixom.net> wrote:
>> > On Tue, Jul 31, 2012 at 9:59 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
>> >> On Wed, Aug 1, 2012 at 12:55 PM, Olof Johansson <olof@lixom.net> wrote:
>> >>> On Tue, Jul 31, 2012 at 9:48 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
>> >>>> On Tue, Jul 31, 2012 at 9:46 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
>> >>>>> Russell, Arnd and Olof,
>> >>>>>
>> >>>>
>> >>>> I felt very sorry about this issue, the email was archived
>> >>>> automatically in my Gmail account. I found the root cause of the issue
>> >>>> Russell met and actually that code about trigger_data is totally
>> >>>> useless, which was removed just now. I pushed an update version again
>> >>>> to the same branch of my git tree. Please consider a pull. If I did
>> >>>> something bad, please let me know, I will fix it as soon as possible.
>> >>>
>> >>> Hi,
>> >>>
>> >>> We'll pull this in for staging again once the merge window is done.
>> >>> It's definitely not 3.6 material at this time.
>> >>>
>> >>
>> >> OK, I will rebase to 3.6-rc1 after merge window close and send out
>> >> pull request again.
>> >
>> > No need to rebase unless there are large merge conflicts.
>> >
>>
>> Olof, could you please consider pull again this branch? I keep it
>> based on 3.5 release.
>
> So what's the fix you've applied?  I don't think you've posted any patches.

I assume I need update my branch instead of posting some incremental
patches, since my branch was dropped. So I prepared a new branch
including the fixing.

Need I post my fix? But I don't keep the old version.
Olof and Arnd, maybe you guys keep my old version.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer    +86.186-168-78255 Mobile
Canonical Ltd.      www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
