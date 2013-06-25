From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 26 Jun 2013 01:30:14 +0900
Subject: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
In-Reply-To: <20130624174903.GA6795@mithrandir>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <1371766383-29077-12-git-send-email-tomasz.figa@gmail.com>
 <2925617.TjWXJcIKRC@flatron> <51C86442.6090406@samsung.com>
 <20130624174903.GA6795@mithrandir>
Message-ID: <51C9C596.4060906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/13 02:49, Thierry Reding wrote:

[...]

> Note that you can't apply patches that touch the PWM tree without my Ack
> and I already mentioned that the current way this driver is written
> isn't acceptable.
>
> So either you fix it properly, or if everybody except me thinks we don't
> need a proper design for drivers anymore, then the only way I'll accept
> this driver into the PWM tree is if you put a really big comment at the
> top of the file saying that the driver is badly designed on purpose and
> that people shouldn't be using it as a reference.
>
Thierry, hmm...I thought Tomasz addressed comments from you and probably 
there are some comments I I missed...OK, I see what your concern is.

Let me drop this series for upcoming merge window.

- Kukjin
