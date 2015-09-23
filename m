From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 23 Sep 2015 21:25:55 +0200
Subject: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
In-Reply-To: <CAGsJ_4zaWcmGsc82=LSohK0UHxJir2OJOBSgoU3sPRXYvLdOZQ@mail.gmail.com>
References: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
 <CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
 <CAGsJ_4wvvQdyjFi=JmWfASm-LbJMybrhC=Wxxn7jHZEP5dUfEw@mail.gmail.com>
 <CAPDyKFpEwWvu3tnbMT9ZvM0TUvEHp0Qa8PADohyJoTaNZ9HS9g@mail.gmail.com>
 <CAGsJ_4x5Nd3Cts1BHsUyB_mCejxbHPPjznUVWUcFoZhxKy+Tcg@mail.gmail.com>
 <CAPDyKFpWfY9G4WG_GfCutJ2NkRbcAYZToYJXp3RvX=_25sgnWA@mail.gmail.com>
 <CAGsJ_4zaWcmGsc82=LSohK0UHxJir2OJOBSgoU3sPRXYvLdOZQ@mail.gmail.com>
Message-ID: <CAPDyKFrj7mfxYPotHfpYPVf8M=Mvjcz+HfuB871EZNv9FWpPqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>
>> Also, I was giving this a second thought...
>>
>> What happens with the SD 3.0 card when it *doesn't* support CMD19.
>> Will it still be functional afterwards or will it move from "transfer
>> state" to another not known state?
>
> uffe, i am not the expert of this issue but weijun is. weijun told that
> for the cards who don't support cmd19, it will take it as illegal
> command and not response it. and it also sets illegal command error in
> registers.
> but the card status is still functional and doesn't cause unknown state.
>
> so maybe we can just ignore the err of tuning, and use the second
> patch with the refine you mentioned?

Sure, let's do that. Please send a v2 of the patchset then.

Kind regards
Uffe
