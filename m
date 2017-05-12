From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 12 May 2017 12:14:49 +0100
Subject: [RFC kvm-unit-tests PATCH 5/8] Makefile: add explicit mkdir for
 .o targets
In-Reply-To: <bac2056a-c771-6188-0066-7e3236719ff0@redhat.com>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
 <20170406190727.5624-6-alex.bennee@linaro.org>
 <a8eb190a-3487-1a89-0069-789b62860b3e@redhat.com> <87mvaj4din.fsf@linaro.org>
 <bac2056a-c771-6188-0066-7e3236719ff0@redhat.com>
Message-ID: <87k25m4992.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/05/2017 17:30, Alex Benn?e wrote:
>>>>
>>>>  %.o: %.S
>>>> +	mkdir -p $(dir $@)
>>> Should this use @ for cleanliness?
>> > I'm not sure I follow. Did you mean use $(@D) directly?
>
> That too, but I was thinking of using "@mkdir" to avoid spamming the
> output with mkdir commands.

Gotcha.

>
> Paolo


--
Alex Benn?e
