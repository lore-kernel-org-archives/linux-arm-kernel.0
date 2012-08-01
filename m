From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Jul 2012 21:55:38 -0700
Subject: [GIT PULL] LED CPU trigger driver and ARM LED code consolidation
 (v2)
In-Reply-To: <CAK5ve-+wWWARGz4ky_VW2AK7hHLXENkw2ANToLztcDjsegubsw@mail.gmail.com>
References: <CAK5ve-KjK2mU0qjdp2HK5CdrM=eQ-hN0nw-0cJj7HGuRyGjH8w@mail.gmail.com>
 <CAK5ve-+wWWARGz4ky_VW2AK7hHLXENkw2ANToLztcDjsegubsw@mail.gmail.com>
Message-ID: <CAOesGMhK3bkk+86jDM7bd6rFUE_RuTGWiWsB7SYJ=i2NocOiLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 9:48 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
> On Tue, Jul 31, 2012 at 9:46 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
>> Russell, Arnd and Olof,
>>
>
> I felt very sorry about this issue, the email was archived
> automatically in my Gmail account. I found the root cause of the issue
> Russell met and actually that code about trigger_data is totally
> useless, which was removed just now. I pushed an update version again
> to the same branch of my git tree. Please consider a pull. If I did
> something bad, please let me know, I will fix it as soon as possible.

Hi,

We'll pull this in for staging again once the merge window is done.
It's definitely not 3.6 material at this time.


-Olof
