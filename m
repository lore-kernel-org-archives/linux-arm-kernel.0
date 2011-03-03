From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 3 Mar 2011 12:43:14 -0300
Subject: [PATCH] ARM: mx51: Print silicon revision on boot
In-Reply-To: <87lj0wwr0g.fsf@lebrac.rtp-net.org>
References: <1299114747-14091-1-git-send-email-festevam@gmail.com>
	<87lj0wwr0g.fsf@lebrac.rtp-net.org>
Message-ID: <AANLkTinPvxKR0ppW5jKWSOw=x05w0tb6_d6x+e4ZWdan@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Thu, Mar 3, 2011 at 5:24 AM, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
> Fabio Estevam <festevam@gmail.com> writes:
> Hi,
>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Why I like having boot log, I don't like have too verbose boot logs. If
> you add this, you have a good reason (I hope), but I can't know
> it. There's no patch description. So, please give a patch with proper
> explanation of why you need that. Anyway, having a proper patch
> description is imho always a good idea.

I think that printing the silicon version on boot is useful
information. Many issues are fixed in the latest silicon revision, so
while debugging mx51 issues it is good to know from the boot log if
someone is using the latest silicon version or not.

We currently do that on mx31/mx35 kernel, and I think it would be nice
to have this information for mx5 as well.

It is just a single line, so don?t believe it will add any significant overhead.

> Moreover, there's already good hint if you want to know if you're on to2
> or to3. On rev < 3.0, you have this in logs:
> VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 2
> Turning off NEON support, detected broken NEON implementation

Ok, but still I prefer one single line stating the CPU version explicitly.

Regards,

Fabio Estevam
