From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 1 Apr 2013 14:56:30 -0700
Subject: [RFC][PATCH 0/5] Introduce .get_voltage callback into voltdm
In-Reply-To: <alpine.DEB.2.00.1303310234110.6436@utopia.booyaka.com>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
 <alpine.DEB.2.00.1303310234110.6436@utopia.booyaka.com>
Message-ID: <CAPtuhTgNQShFvfe+AyN-uFJuFL85V1ceT-udWqFMeUUbmjhqmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 30, 2013 at 7:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Mike, Kevin,
>
> On Wed, 3 Oct 2012, Mike Turquette wrote:
>
>> From: Mike Turquette <mturquette@linaro.org>
>>
>> This series creates a new callback for struct voltagedomain,
>> .get_voltage.  This fetches the voltage from hardware, if possible, and
>> returns it to the caller.  We use this call to populate
>> voltdm->nominal_volt at boot time.
>
> Just checking on the status of this series.  Is this superseded by
> Andrii's driver?  Does it need to be reposted for merging?  etc.
>

Hi Paul,

Thanks for resurrecting this thread.  This series is needed if the ABB
transition is triggered by the OMAP VC/VP code.  Andrii's approach
triggers an ABB transition based on the clock rate-change notifiers
but that is still in discussion.

So the short answer is "I don't know yet".

Regards,
Mike

>
> - Paul
