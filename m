From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 20 Aug 2015 08:03:33 -0700
Subject: [Xen-devel] [PATCH v3 00/20] xen/arm64: Add support for 64KB page
In-Reply-To: <55D5A7CB.3070207@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <55D521F2.5080504@citrix.com> <55D5A7CB.3070207@citrix.com>
Message-ID: <55D5EC45.5010306@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/08/2015 03:11, David Vrabel wrote:
> On 20/08/15 01:40, Julien Grall wrote:
>> Hi,
>>
>> Ping? I'm missing some reviews on block and netfront code.
>>
>> We'd like to see this series going in Linux 4.3. Some distributions
>> plans to use this version for aarch64 support. If we miss it, we won't
>> have any Xen guests support, even it's minimal, for Linux using 64KB
>> page granularity.
>
> This is too late for Linux 4.3.

May I know why it's too late for Linux 4.3? AFAICT, Linux 4.2 is not yet 
out and therefore the merge window for Linux 4.3 is not yet opened.

Regards,

-- 
Julien Grall
