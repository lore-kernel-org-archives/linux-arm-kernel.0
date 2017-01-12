From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 12 Jan 2017 18:44:27 +0100
Subject: [kvm-unit-tests PATCH 1/6] libcflat: add PRI(dux)32 format types
In-Reply-To: <87fuko2o4e.fsf@linaro.org>
References: <20170111162841.15569-1-alex.bennee@linaro.org>
 <20170111162841.15569-2-alex.bennee@linaro.org>
 <4286b719-ff75-d2cd-68b5-cb9d9bb89553@redhat.com>
 <20170112165629.nbczamlqlpsqaauh@hawk.localdomain>
 <87fuko2o4e.fsf@linaro.org>
Message-ID: <144fdce4-ddd4-0c93-296b-44aeec57c664@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/01/2017 18:18, Alex Benn?e wrote:
>> Although I feel there should be a compiler macro way to do this without
>> a need for configure/makefile trickery at all...
> 
> I did ask our toolchain bods. They started going on about potential
> solutions using _Generic but I fear that might be worse in this case!

I don't think _Generic can do string concatenation, can it?

inttypes.h is not part of the set of freestanding headers, only stdint.h
is.  Who is providing stdint.h in your case?

Paolo
