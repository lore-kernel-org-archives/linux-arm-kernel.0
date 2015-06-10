From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 10 Jun 2015 18:01:46 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.2, part 2, version 2
In-Reply-To: <CAMAWPa8wiKu-zha0gUSetnenLNjBt7OGm8NU8RCbMXoDD4qYZg@mail.gmail.com>
References: <1433533151-6301-1-git-send-email-dinh.linux@gmail.com>
 <7hh9qfjhht.fsf@deeprootsystems.com>
 <CAMAWPa8wiKu-zha0gUSetnenLNjBt7OGm8NU8RCbMXoDD4qYZg@mail.gmail.com>
Message-ID: <5578C1DA.6040105@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2015 06:03 PM, Kevin Hilman wrote:
> On Wed, Jun 10, 2015 at 4:01 PM, Kevin Hilman <khilman@kernel.org> wrote:
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
>>
>> If there are no deps, could you respin this against -rc2/-rc3, or you
>> could also rebase on top of your previous socfpga_updates_for_v4.2 as
>> well (which itself is based on -rc2.)
> 
> Actually, no need to respin since this is just a single patch.  I've
> picked it from your branch and applied it to socfpga/soc and merged
> into next/soc.  But please keep in mind the above for future pull
> reqs.  Thanks.
> 

Ok, will do.

Thanks,

Dinh
