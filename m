From: kvalo@codeaurora.org (Kalle Valo)
Date: Fri, 20 Mar 2015 16:00:47 +0200
Subject: [PATCH v6 2/6] wl12xx: use frequency instead of enumerations for
 pdata clocks
In-Reply-To: <20150316151554.GO5264@atomide.com> (Tony Lindgren's message of
 "Mon, 16 Mar 2015 08:15:55 -0700")
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <20150313150047.GI5264@atomide.com>
 <CAB3XZEcOytqpJ4pWoemLS3d+DCeA8C75MencDfGn_vhfEYrduw@mail.gmail.com>
 <3103538.jZ037SODdT@wuerfel> <87lhixphag.fsf@kamboji.qca.qualcomm.com>
 <20150316151554.GO5264@atomide.com>
Message-ID: <87siczg44w.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

>> I prefer these going through the omap tree. Like Eliad said,
>> drivers/net/wireless/ti does not get that many changes nowadays so the
>> chances of this patchset conflicting with something is very small.
>
> OK great. In that case no need to rearrange the patches, I can
> apply them into an immutable branch once the pending issues have
> been fixed if Kalle acks them.
>
> To avoid merge conflicts that branch is easiest done against
> v4.0-rc4. Kalle and Arnd, does that work for you guys?
>
> I can also base it on 5b7610f23562 ("ARM: OMAP2+: Fix wl12xx on
> dm3730-evm with mainline u-boot") that's on top of -rc2 plus few
> other fixes now merged to -rc4 mainline if we need a branch based
> on an earlier tag.

Sorry, it seems I forgot to answer this one:

Either baseline is good for me, I can't think of any problems with
either one. But please do remember that I'm a new maintainer, I might
very well miss something ;)

-- 
Kalle Valo
