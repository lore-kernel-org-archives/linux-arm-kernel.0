From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 01 Oct 2010 14:15:58 -0700
Subject: [PATCH] ARM: add cpu_idle_wait() to support CPUidle on SMP
	systems.
In-Reply-To: <AANLkTi=EkQNd4JFrwCY1qH6XOq0+O_5ZuxaJY1dQg=cw@mail.gmail.com>
	(Colin Cross's message of "Thu, 30 Sep 2010 11:04:28 -0700")
References: <1285692192-32075-1-git-send-email-khilman@deeprootsystems.com>
	<87hbh7f9dl.fsf@deeprootsystems.com>
	<AANLkTi=EkQNd4JFrwCY1qH6XOq0+O_5ZuxaJY1dQg=cw@mail.gmail.com>
Message-ID: <87sk0p7gxd.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross <ccross@google.com> writes:

> On Thu, Sep 30, 2010 at 10:07 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Russell,
>>
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>
>>> In order for CPUidle to work on SMP systems, an implementation of
>>> cpu_idle_wait() is needed.
>>>
>>> This patch duplicates the x86 implementation of cpu_idle_wait() for
>>> ARM.
>>>
>>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Are you OK with this for the patch system for 2.6.37?
>
> Tested-by: Colin Cross <ccross@android.com>
>
> CPUidle works on Tegra2 with this patch.

Thanks for testing.

Patch is now queued in Russell's patch system as 6428/1

   http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6428/1

Kevin
