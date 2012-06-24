From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sun, 24 Jun 2012 12:21:19 +0200
Subject: [PATCH 1/1] ARM: only call smp_send_stop() on SMP
In-Reply-To: <20120624085943.GC19226@n2100.arm.linux.org.uk>
References: <1340511667-4976-1-git-send-email-javier@dowhile0.org>
 <20120624085943.GC19226@n2100.arm.linux.org.uk>
Message-ID: <CABxcv=n4MSQ=9S-iaVjO3wZ5+CoonYt28Fss+69byD83C0FzNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 24, 2012 at 10:59 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> See this thread:
>
> http://lists.arm.linux.org.uk/lurker/thread/20120523.200015.2fdfd505.en.html
>
> There are times when I wonder why I bother replying to email on mailing
> lists. ?No patch ever came from my responses on this subject. ?Not going
> to repeat it again. ?Fed up.
>
> On Sun, Jun 24, 2012 at 06:21:07AM +0200, Javier Martinez Canillas wrote:

Hi Russell,

I didn't know that this was discussed before sorry.

I'll send a v2 of the patch that uses your suggested approach.

Best regards,
Javier
