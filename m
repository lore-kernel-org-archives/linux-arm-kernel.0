From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 02 Apr 2012 12:14:46 -0700
Subject: error: 'SEGMENT_SIZE' undeclared with arm-eabi-gcc toolchain
In-Reply-To: <alpine.LFD.2.02.1203310017440.24151@xanadu.home>
References: <4F7638C3.4060301@samsung.com>
 <alpine.LFD.2.02.1203310017440.24151@xanadu.home>
Message-ID: <4F79FAA6.8060900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Fri, 30 Mar 2012, Kukjin Kim wrote:
>

[...]

Hi Nicolas,

> So the clue you're looking for is probably on the 18th line above.
>
Ah Yep, I see.

> BTW, no one is using a.out on ARM anymore.  You should really consider
> removing CONFIG_BINFMT_AOUT from your config.
>
Oh, now s3c2410_defconfig has it. OK, let me fix it.

Thank you for your time and kindly explanation.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
