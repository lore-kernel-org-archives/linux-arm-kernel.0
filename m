From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Jan 2015 20:45:10 -0800
Subject: [GIT PULL RESEND] pxa for v3.20
In-Reply-To: <87lhkoq1ff.fsf@free.fr>
References: <87egqpff9m.fsf@free.fr> <20150123215423.GD20896@quad.lixom.net>
 <874mrgdzz0.fsf@free.fr> <20150127021733.GB22154@quad.lixom.net>
 <87lhkoq1ff.fsf@free.fr>
Message-ID: <CAOesGMga4MB+q740uj1Li4Mnq6kXxQzKk_cf0YKjt5aj5_GFLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 8:42 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Olof Johansson <olof@lixom.net> writes:
>
>> I had already merged, but it looks like you broke viper and zeus. Both of them
>> still refer to PXA_ISA_IRQ().
>>
>> Can you send an incremental patch for that? Or if you prefer that we drop this
>> branch for now while you sort it out that's OK too -- your preference.
> I'll send an incremental patch.
> I'm really frustrated my bot didn't catch that, I suppose yours caught it by
> building viper_defconfig ...

Yeah, I build all defconfigs.

>> Yeah we normally scale this by educating downstream maintainers. checkpatch is
>> useful in many cases but making it do everything is hard.
> Yeah, but humans do forget, even educated ... I'll be carefull as much as I can,
> but I knew the rule and yet this slipped through.

Oh, no worries. We're all human, which is why I pointed it out when I
noticed it. Next time I might miss it too. It happens.


-Olof
