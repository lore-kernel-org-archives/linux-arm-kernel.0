From: graeme@xora.org.uk (Graeme Gregory)
Date: Tue, 5 Apr 2016 14:08:56 +0100
Subject: [PATCH v15 0/6] arm64, numa: Add numa support for arm64 platforms
In-Reply-To: <56F1BD15.4000701@caviumnetworks.com>
References: <1457481587-8976-1-git-send-email-ddaney.cavm@gmail.com>
 <56F1936E.1090407@redhat.com> <56F1BD15.4000701@caviumnetworks.com>
Message-ID: <5703B8E8.3080408@xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/03/16 21:45, David Daney wrote:
> On 03/22/2016 11:48 AM, Jon Masters wrote:
>> On 03/08/2016 06:59 PM, David Daney wrote:
>>
>>> From: David Daney <david.daney@cavium.com>
>>>
>>> v15:
>>>
>>>     - Make the distance-map node optional (again), if it is not in
>>>            the device tree, default values are used.
>>>
>>>     - Minor cleanups to of_numa.c as suggested by Rob Harring.
>>
>> Hi David, all,
>>
>> Wondering what the status of this patch series is currently?
>
> I haven't seen any feedback on v15.  My assumption was that the relevant
> arm64 maintainers would take some sort of action after the merge window
> quiets down.
>
> In any event, I am happy to make any improvements that may be suggested.
>
Post merge window series does not apply to 4.6-rc2 or next.

Patch 4 collides in arch/arm64/mm/mmu.c

Thanks

Graeme
