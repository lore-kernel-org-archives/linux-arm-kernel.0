From: sjg@chromium.org (Simon Glass)
Date: Thu, 19 May 2011 22:24:31 -0700
Subject: [PATCH v4] ARM: Use generic BUG() handler
In-Reply-To: <20110426014741.GB28721@quad.lixom.net>
References: <1302822031-6752-1-git-send-email-sjg@chromium.org>
	<4DA7A914.5020804@codeaurora.org>
	<BANLkTikcY-xzjd0W77UfWWoO8ibjKNXQGg@mail.gmail.com>
	<BANLkTin_TpzdQS96SPKUNye6vb2b55Qc4A@mail.gmail.com>
	<143ea9b1bb96e613d534caa7cb3a1e2d.squirrel@www.codeaurora.org>
	<20110426014741.GB28721@quad.lixom.net>
Message-ID: <BANLkTikHT2E=76jMLbzmQm_CiUw8rA3cCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 6:47 PM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Apr 20, 2011 at 11:01:59AM -0700, Stephen Boyd wrote:
>
>> It's here:
>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6885/1
>>
>> I imagine it will be added when/if Russell picks it up. Sadly it
>> increases the LOC in ARM so Simon might need to really
>> sell it to get it merged.
>
> It's core code though, and the concern today is not with ARM core code
> as much as with the various platforms that are growing seemingly without
> upper bounds.

Hi,

Can anyone advise please what happens next with this patch? So far I
have posted it to the list, it has been reviewed on the list and I
have put it into the patch system. What is the next step please to get
this into the kernel?

Regards,
Simon

>
>
> -Olof
>
