From: stefan@agner.ch (Stefan Agner)
Date: Wed, 20 May 2015 00:42:21 +0200
Subject: [PATCH soc v8 0/3] ARM: vf610m4: Add Vybrid Cortex-M4 support
In-Reply-To: <1432073032-26561-1-git-send-email-stefan@agner.ch>
References: <1432073032-26561-1-git-send-email-stefan@agner.ch>
Message-ID: <12f1cde68eef7d4e35646e83aabae5c3@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-20 00:03, Stefan Agner wrote:
> This is the soc part of the splitted patchset which enables Cortex-M4
> support on Vybrid, as discussed in the thread of patchset v7.

Arnd, forgot to mention that this depends on the irqchip changes merged
by Thomas, see
https://lkml.org/lkml/2015/5/19/204

--
Stefan
