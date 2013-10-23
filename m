From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 23 Oct 2013 10:06:31 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131022171346.GE4061@obsidianresearch.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
Message-ID: <20131023080630.GA14413@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 11:13:46AM -0600, Jason Gunthorpe wrote:
> The question I asked last time this came up, which was left unaswered:
> 
>  Who does this stable DT ABI vision benifit, and how much is that
>  benifit worth?

[Sigh]

I already answered this question more than once. I guess it doesn't
hurt to answer it again: It helps the users. Please, don't forget
about them.

If I, as an embedded developer, design my board to work with kernel
version N and a given DTB, then I can upgrade to any kernel version
M (where M > N) using the *same* DTB, and it still works.

Thanks,
Richard
