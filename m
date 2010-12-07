From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 7 Dec 2010 17:55:00 +0800
Subject: [PATCHv2] support PMIC mc13892
In-Reply-To: <87pqtdncpl.fsf@lechat.rtp-net.org>
References: <1291708905-23645-1-git-send-email-b00984@freescale.com>
	<87pqtdncpl.fsf@lechat.rtp-net.org>
Message-ID: <AANLkTikr5egA+mktGwCUfT8eHvnTBt6VmYxx3eb-eL4W@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 7, 2010 at 5:39 PM, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
> <b00984@freescale.com> writes:
>
>> From: Yong Shen <yong.shen@linaro.org>
>>
>> add support for mc13892, tested on mx51 babbage board
>
> I've compared this version with mine, checked & tested it. I'm happy
> with it and moreover it has the nice idea to work on my efikamx.
>
> I'm not sure if it should be a signed-off-by: or acked-by: or reviewed-by:
> tag since I wrote the code you've used a basis. I'm putting my s-o-b but
> if I'm wrong, I do hope someone will correct it.
>
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>

It is nice that you mention this issue. I was also wondering for a
while about what should I do about this, I was not sure, so I put
Arnaud in the head comments. Is there any conventions for this? I am
OK with:
Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Signed-off-by: Yong Shen <yong.shen@linaro.org>

It seems that I should send out a new patch for this, or can I just
ask maintainer who is responsible for merging this patch to change the
s-o-b?

Yong
