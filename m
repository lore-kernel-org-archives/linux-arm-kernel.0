From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 3 Feb 2011 18:06:59 +0000
Subject: [PATCH REPOST] ARM: bitops: Use BX instead of MOV PC,LR
In-Reply-To: <AANLkTinC_+3We3pSffhry6K3VqzZc6Db7DL=eDfjtNMp@mail.gmail.com>
References: <1296672824-22743-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1102021421160.8580@xanadu.home>
	<20110202212449.GF31043@n2100.arm.linux.org.uk>
	<20110203104420.GA2666@arm.com> <20110203104751.GB2666@arm.com>
	<AANLkTinC_+3We3pSffhry6K3VqzZc6Db7DL=eDfjtNMp@mail.gmail.com>
Message-ID: <AANLkTi=MG2XJBxFhrQjJMT1PZVKQJwmzYH9k1Fr1JfkL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 3, 2011 at 4:27 PM, Rabin Vincent <rabin@rab.in> wrote:
> On Thu, Feb 3, 2011 at 16:17, Dave Martin <dave.martin@linaro.org> wrote:
>> BX is appropriate here because this code is predicated on
>> __LINUX_ARM_ARCH__ >= 6.
>
> But you're modifying the #else portion too?
>

Darn, you're quite right... thanks for spotting that!

Will repost.

Cheers
---Dave
