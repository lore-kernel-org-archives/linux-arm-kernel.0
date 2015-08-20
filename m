From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 20 Aug 2015 16:15:05 +0100
Subject: [Xen-devel] [PATCH v3 00/20] xen/arm64: Add support for 64KB page
In-Reply-To: <55D5EC45.5010306@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <55D521F2.5080504@citrix.com> <55D5A7CB.3070207@citrix.com>
 <55D5EC45.5010306@citrix.com>
Message-ID: <55D5EEF9.7080904@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/15 16:03, Julien Grall wrote:
> 
> 
> On 20/08/2015 03:11, David Vrabel wrote:
>> On 20/08/15 01:40, Julien Grall wrote:
>>> Hi,
>>>
>>> Ping? I'm missing some reviews on block and netfront code.
>>>
>>> We'd like to see this series going in Linux 4.3. Some distributions
>>> plans to use this version for aarch64 support. If we miss it, we won't
>>> have any Xen guests support, even it's minimal, for Linux using 64KB
>>> page granularity.
>>
>> This is too late for Linux 4.3.
> 
> May I know why it's too late for Linux 4.3? AFAICT, Linux 4.2 is not yet
> out and therefore the merge window for Linux 4.3 is not yet opened.

Because:

a) There's nothing suitable to apply yet (need a v4 series)
b) The merge window opens this weekend (probably).
c) What's currently queued for 4.3 has been tested and no further tests
can be run until next week (when Boris or Konrad get back).

FWIW, "mm, xen/balloon: memory hotplug improvements" has also not been
queued for 4.3 for similar reasons (despite this series being ready 4
days ago and it having been more extensively tested inside XenServer).

David
