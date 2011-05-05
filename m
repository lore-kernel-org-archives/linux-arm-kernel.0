From: vitalywool@gmail.com (Vitaly Wool)
Date: Thu, 5 May 2011 22:05:12 +0200
Subject: [RFC PATCH] arm: drop Execute-In-Place
In-Reply-To: <alpine.LFD.2.00.1105051518580.24613@xanadu.home>
References: <1304607121-13612-1-git-send-email-plagnioj@jcrosoft.com>
	<4DC2E5AA.5010604@am.sony.com> <4DC2E669.2000101@am.sony.com>
	<1304620350.2398.29.camel@i7.infradead.org>
	<4DC2EF19.5010309@am.sony.com>
	<alpine.LFD.2.00.1105051453280.24613@xanadu.home>
	<BANLkTimfKJPcDN+L4+z1DnsMv_BMOHpyew@mail.gmail.com>
	<4DC2F6B0.80800@am.sony.com>
	<alpine.LFD.2.00.1105051518580.24613@xanadu.home>
Message-ID: <BANLkTik7z+rJDCAaVo5uGgMhbtpWps453g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2011 at 9:27 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> Just to be clear... We have XIP in the tree already. ?If it is useful
> to someone, in-tree or out-of-tree, then it is worth keeping around.
> Even if the only user was out-of-tree which certainly wasn't the case
> when I added XIP support to the kernel, then ripping it out and adding
> it back later would be more trouble than preserving it.
>
> What I was asking recently is whether or not XIP is still useful to
> someone today. ?Apparently it is, which is the answer I was looking for.

Surely it is. The last thing I tried was the i.mx deviation which is
very much based on what's in the tree. It didn't work out without some
bits of hackery and I never got it straight enough to try upstreaming.

But nevertheless, IMO XIP is not dead and is not going to be in the
closest future.

~Vitaly
