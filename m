From: olof@lixom.net (Olof Johansson)
Date: Fri, 13 Jul 2018 12:58:44 -0700
Subject: [PATCH] arm64: build with baremetal linker target instead of
 Linux when available
In-Reply-To: <33f65453-5b6d-0684-8a91-7e9940846143@redhat.com>
References: <20180713150701.GA3049@arm.com>
 <20180713153033.20540-1-olof@lixom.net>
 <33f65453-5b6d-0684-8a91-7e9940846143@redhat.com>
Message-ID: <CAOesGMj6m8q1aRz0k3qPTo2-Fur66nSsBaVNxcDnrrmWbUxe-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 12:21 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 07/13/2018 08:30 AM, Olof Johansson wrote:
>>
>> Not all toolchains have the baremetal elf targets, RedHat/Fedora ones
>> in particular. So, probe for whether it's available and use the previous
>> (linux) targets if it isn't.
>>
>
>
> For the Fedora toolchains:
>
> Tested-by: Laura Abbott <labbott@redhat.com>

Thanks!


-Olof
