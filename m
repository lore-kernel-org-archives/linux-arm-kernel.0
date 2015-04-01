From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 1 Apr 2015 17:09:20 +0100
Subject: [PATCH v2 03/10] KVM: arm: guest debug, define API headers
In-Reply-To: <87h9szyh0p.fsf@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-4-git-send-email-alex.bennee@linaro.org>
 <20150401174646.74f695bd@thinkpad-w530> <87h9szyh0p.fsf@linaro.org>
Message-ID: <CAFEAcA-Rv9JX_NGQ4=yP6M-6Dx=iXc73xgU-HA=y2LasMgbTCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 April 2015 at 17:01, Alex Benn?e <alex.bennee@linaro.org> wrote:
>
> David Hildenbrand <dahi@linux.vnet.ibm.com> writes:

>>> +/*
>>> + * See ARM ARM D7.3: Debug Registers
>>
>> Maybe drop one ARM
>
> Well technically it is the ARM Architecture Reference Manual but that's
> quite long winded.

Dropping one "ARM" would be actively wrong, so don't do that.
You probably want to say 'v8 ARM ARM", assuming you mean that.

-- PMM
