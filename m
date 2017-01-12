From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 12 Jan 2017 12:35:03 +0000
Subject: [kvm-unit-tests PATCH 4/6] docs: mention checkpatch in the README
In-Reply-To: <322298cd-aefa-e945-d3f4-1237767a06ef@redhat.com>
References: <20170111162841.15569-1-alex.bennee@linaro.org>
 <20170111162841.15569-5-alex.bennee@linaro.org>
 <322298cd-aefa-e945-d3f4-1237767a06ef@redhat.com>
Message-ID: <87lgug318o.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/01/2017 17:28, Alex Benn?e wrote:
>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>> ---
>>  README.md | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/README.md b/README.md
>> index 5027b62..9462824 100644
>> --- a/README.md
>> +++ b/README.md
>> @@ -79,3 +79,4 @@ You can add the following to .git/config to do this automatically for you:
>>      [format]
>>          subjectprefix = kvm-unit-tests PATCH
>>
>> +Please run the kernel's ./scripts/checkpatch.pl on new patches
>
> Does it really work well on kvm-unit-tests?

Well I keep getting pulled up on kernel coding style on my reviews so if
we mean it we should enforce it.

--
Alex Benn?e
