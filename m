From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 17:10:39 -0700
Subject: [GIT PULL] SoCFPGA updates for v4.2, part 2, version 2
In-Reply-To: <5578C1AA.3000307@opensource.altera.com> (Dinh Nguyen's message
 of "Wed, 10 Jun 2015 18:00:58 -0500")
References: <1433533151-6301-1-git-send-email-dinh.linux@gmail.com>
 <7hh9qfjhht.fsf@deeprootsystems.com>
 <5578C1AA.3000307@opensource.altera.com>
Message-ID: <7hmw07gl4w.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dinh Nguyen <dinguyen@opensource.altera.com> writes:

> On 06/10/2015 06:01 PM, Kevin Hilman wrote:
>> dinh.linux at gmail.com writes:
>> 
>>> Hi Arnd, Kevin, Olof,
>>>
>>> This is an updated pull request for the supend-to-ram patch that has the
>>> EDAC code removed in order to avoid a merge conflict.
>>>
>>> Thanks,
>>> Dinh
>>>
>>> The following changes since commit c65b99f046843d2455aa231747b5a07a999a9f3d:
>>>
>>>   Linux 4.1-rc6 (2015-05-31 19:01:07 -0700)
>> 
>> Why v4.1-rc6?  
>> 
>> Are there specific dependencies there?  If not, we prefer these pulls to
>> be on older -rc tags (typically nothing past where arm-soc/master is).
>
> No dependency, I just saw that arm-soc/for-next was at -rc6. I remember
> seeing an email that you should based to an early -rc, or the same -rc
> as the for-next branch?

Same -rc as the master branch preferably.

Thanks,

Kevin
