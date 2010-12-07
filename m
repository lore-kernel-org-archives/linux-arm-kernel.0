From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Dec 2010 11:54:29 +0000
Subject: [PATCHv2] support PMIC mc13892
In-Reply-To: <AANLkTikr5egA+mktGwCUfT8eHvnTBt6VmYxx3eb-eL4W@mail.gmail.com>
References: <1291708905-23645-1-git-send-email-b00984@freescale.com>
	<87pqtdncpl.fsf@lechat.rtp-net.org>
	<AANLkTikr5egA+mktGwCUfT8eHvnTBt6VmYxx3eb-eL4W@mail.gmail.com>
Message-ID: <20101207115429.GB4698@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 05:55:00PM +0800, Yong Shen wrote:
> On Tue, Dec 7, 2010 at 5:39 PM, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:

> > I'm not sure if it should be a signed-off-by: or acked-by: or reviewed-by:
> > tag since I wrote the code you've used a basis. I'm putting my s-o-b but
> > if I'm wrong, I do hope someone will correct it.

> > Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

> It is nice that you mention this issue. I was also wondering for a
> while about what should I do about this, I was not sure, so I put
> Arnaud in the head comments. Is there any conventions for this? I am
> OK with:
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Signed-off-by: Yong Shen <yong.shen@linaro.org>

A signoff has a very specific meaning which would in this situation mean
that Arnaud wrote part of the patch - see SubmittingPatches.  Otherwise
a Tested-by and/or Reviewed-by seem appropriate (with the obvious
meanings).

> It seems that I should send out a new patch for this, or can I just
> ask maintainer who is responsible for merging this patch to change the
> s-o-b?

Maintainers will usually take care of this, but if you need to resend
please do include tags that still apply.
