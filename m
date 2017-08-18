From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 18 Aug 2017 09:46:43 +0100
Subject: for-next/core ACPI boot issue
In-Reply-To: <f485ae4c-579c-d84b-d138-fbd6b6a87cda@riken.jp>
References: <6813810f-4222-56e0-6285-5cb7cb65303c@riken.jp>
 <20170817173331.GA19028@red-moon>
 <f485ae4c-579c-d84b-d138-fbd6b6a87cda@riken.jp>
Message-ID: <20170818084643.GB24764@e107981-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 04:36:28AM +0900, Itaru Kitayama wrote:
> Lorenzo,
> I'm afraid not. I was trying to see if the HEAD of for-next/core boot
> with acpi=force. Given VMAP'ed stack support may be intrusive to the
> kernel, I specifically mentioned it as it sits at the top of the patch
> stack then. I'm on a RevA3 CPU at this moment.
> 
> Itaru

Hi Itaru,

I am afraid it is a bit vague for me to be able to help, if you can
bisect the issue down to a given commit that would be helpful.

Thanks,
Lorenzo
