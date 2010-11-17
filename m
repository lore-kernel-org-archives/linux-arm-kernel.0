From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 17 Nov 2010 16:46:28 +0000
Subject: [PATCH 7/7 v1.1] ARM: Thumb-2: Restore sensible zImage header
	layout for CONFIG_THUMB2_KERNEL
In-Reply-To: <alpine.LFD.2.00.1011171056540.6448@xanadu.home>
References: <1289913277-8822-7-git-send-email-dave.martin@linaro.org>
	<1289992294-7181-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1011171056540.6448@xanadu.home>
Message-ID: <AANLkTinF0At5V5R6VoNBkEFQjpY8VA3OZ_j4oC4bPs52@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 4:17 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

[...]

> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks

> Only a nanonit below that is not that important.

[...]

>> + THUMB( ? ? ? ? ? ? ?.arm ? ? ? ? ? ? ? ? ? ?)
>
> Maybe the THUMB() can be omitted here and .arm be unconditional?

Agreed, that would be less crufty -- I'll make that change locally for
now and repost when I have other changes to push.

Cheers
---Dave
