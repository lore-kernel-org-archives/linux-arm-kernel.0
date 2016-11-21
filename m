From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 21 Nov 2016 17:56:51 +0000
Subject: [PATCH v2 1/5] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <d0f3bc66-6dfd-dcdc-a15d-a8f9fdda6048@arm.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-2-git-send-email-bgolaszewski@baylibre.com>
 <a309a738-7fa7-3aab-4457-f7d693e6b37f@ti.com>
 <CAMpxmJUXJi6PDq0qc-0+r2mLPASLpJUt_njWtXr4Mx4k0Fa82g@mail.gmail.com>
 <d0f3bc66-6dfd-dcdc-a15d-a8f9fdda6048@arm.com>
Message-ID: <6576fc1d-cc16-8d7c-75e7-27c5fbc33101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 21/11/16 17:47, Robin Murphy wrote:
> Hi Bartosz, Sekhar,
>
> On 21/11/16 16:48, Bartosz Golaszewski wrote:

[...]

>> Hi Sekhar,
>>
>> thanks for spotting that.
>>
>> I think we should introduce this function right away, rather than
>> having two static functions doing the same thing. If you don't mind,
>> I'll try to find a good spot for it and send a follow-up series fixing
>> the issue.
>
> As it happens, that was already proposed last week, for much the same
> reason:
>
> http://www.mail-archive.com/linuxppc-dev at lists.ozlabs.org/msg111395.html
>

Thanks for pointing this out, yet another platform to move to the new
API after v4.10.

Hi Shekar, Bartosz,

For v4.10, please continue with the open coding as proposed in this
thread in order to avoid cross tree dependencies. I will rework on the
above patch once v4.10 merge window closes to include all these
occurrence and replace them.

-- 
Regards,
Sudeep
