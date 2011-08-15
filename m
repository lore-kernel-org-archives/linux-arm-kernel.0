From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Aug 2011 09:58:07 +0100
Subject: [PATCH kernel-3.0] arm:cache-l2x0: Fix L2 Cache size calculation.
In-Reply-To: <4E48CF80.6070105@st.com>
References: <1313142327-18320-1-git-send-email-srinivas.kandagatla@st.com>
	<20110812102020.GD14904@e102144-lin.cambridge.arm.com>
	<20110813084129.GM4775@n2100.arm.linux.org.uk>
	<20110814204851.GA1948@e102144-lin.cambridge.arm.com>
	<4E48CF80.6070105@st.com>
Message-ID: <20110815085806.GB22163@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas,

On Mon, Aug 15, 2011 at 08:49:20AM +0100, Srinivas KANDAGATLA wrote:
> Resending the patch with Acked by and CC lines in patch...

As described here:

http://www.arm.linux.org.uk/developer/patches/info.php

You need to use Russell's patch system to submit this patch. If you're using
git, the easiest way to do this is:

(0) Sign up to Russell's patch system (not sure if this required):
    http://www.arm.linux.org.uk/developer/patches/add.php

(1) Add an additional KernelVersion: 3.1-rc2 tag to your patch.

(2) Email it to patches at arm.linux.org.uk using git send-email
    --suppress-cc=all.

Thanks,

Will
