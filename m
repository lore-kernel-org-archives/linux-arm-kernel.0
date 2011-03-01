From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 01 Mar 2011 20:23:36 +0300
Subject: [PATCH] ARM: vexpress ct-ca9x4: only set twd_base if local timers
	are	being used
In-Reply-To: <1288891845-12630-1-git-send-email-will.deacon@arm.com>
References: <1288891845-12630-1-git-send-email-will.deacon@arm.com>
Message-ID: <4D6D2B98.4090501@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Will Deacon wrote:

> In commit bde28b84, I made the assumption that CONFIG_SMP is always set

    Linus asks to also specify the commit summary in parens.

> for the quad-core ct-ca9x4 platform. As it turns out, people who aren't
> using the SMP goodness are confronted with a build failure.

> This patch fixes this issue by ensure that twd_base is only set if
> local timers are being used (and therefore SMP support is configured).

> Reported-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

WBR, Sergei
