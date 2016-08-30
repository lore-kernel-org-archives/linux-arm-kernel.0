From: mmarek@suse.com (Michal Marek)
Date: Tue, 30 Aug 2016 12:50:41 +0200
Subject: [PATCH] arm64: Set UTS_MACHINE in the Makefile
In-Reply-To: <20160830095322.GA24906@arm.com>
References: <1472545895-7237-1-git-send-email-mmarek@suse.com>
 <20160830095322.GA24906@arm.com>
Message-ID: <435a26f2-29ce-f40c-4749-6d8d6d81ac67@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-08-30 11:53, Will Deacon wrote:
> On Tue, Aug 30, 2016 at 10:31:35AM +0200, Michal Marek wrote:
>> The make rpm target depends on proper UTS_MACHINE definition.  Also, use
>> the variable in arch/arm64/kernel/setup.c, so that it's not accidentally
>> removed in the future.
>>
>> Reported-and-tested-by: Fabian Vogt <fvogt@suse.com>
>> Signed-off-by: Michal Marek <mmarek@suse.com>
>> ---
> 
> What exactly do you mean by "proper", here? Is it just the endianness
> suffix that you need?

The default for UTS_MACHINE is the kbuild arch name, which would be arm64.

Michal
