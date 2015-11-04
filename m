From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 04 Nov 2015 13:21:34 -0600
Subject: [PATCH v2 1/2] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <20151104093957.GA31378@dhcp22.suse.cz> (Michal Hocko's message
 of "Wed, 4 Nov 2015 10:39:58 +0100")
References: <1446574204-15567-1-git-send-email-dcashman@android.com>
 <20151104093957.GA31378@dhcp22.suse.cz>
Message-ID: <877flxo9j5.fsf@x220.int.ebiederm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal Hocko <mhocko@kernel.org> writes:

> On Tue 03-11-15 10:10:03, Daniel Cashman wrote:
> [...]
>> +This value can be changed after boot using the
>> +/proc/sys/kernel/mmap_rnd_bits tunable
>
> Why is this not sitting in /proc/sys/vm/ where we already have
> mmap_min_addr. These two sound like they should sit together, no?

Ugh.  Yes.  Moving that file before it becomes part of the ABI sounds
like a good idea.  Daniel when you get around to v3 please move the
file.

Thank you,
Eric
