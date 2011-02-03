From: rabin@rab.in (Rabin Vincent)
Date: Thu, 3 Feb 2011 21:57:22 +0530
Subject: [PATCH REPOST] ARM: bitops: Use BX instead of MOV PC,LR
In-Reply-To: <20110203104751.GB2666@arm.com>
References: <1296672824-22743-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1102021421160.8580@xanadu.home>
	<20110202212449.GF31043@n2100.arm.linux.org.uk>
	<20110203104420.GA2666@arm.com> <20110203104751.GB2666@arm.com>
Message-ID: <AANLkTinC_+3We3pSffhry6K3VqzZc6Db7DL=eDfjtNMp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 3, 2011 at 16:17, Dave Martin <dave.martin@linaro.org> wrote:
> BX is appropriate here because this code is predicated on
> __LINUX_ARM_ARCH__ >= 6.

But you're modifying the #else portion too?
