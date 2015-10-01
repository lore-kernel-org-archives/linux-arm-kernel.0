From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 1 Oct 2015 16:07:09 -0600
Subject: [RFC PATCH 00/20] Coresight integration with perf
In-Reply-To: <87zj04jnlw.fsf@ashishki-desk.ger.corp.intel.com>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <87zj04jnlw.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkxitWS0hUXL_=T-V8qSXKvtyUc8F7NknDu16Xy0nN_o0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2015 at 02:52, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> This patchset aims to integrate configuration and control of
>> the Coresight tracers with the perf sub-system.
>>
>> The goal is to use PMUs to represent tracers and the auxiliary
>> buffer enhancement to collect processor traces.  As such a lot
>> of work is done to move the current Coresight sysFS oriented
>> configuration and control commands to perf's AUX API.
>>
>> For the time being the work concentrates on ETMv3 and ETB1.0
>> sink buffers.  Work on ETMv4 and other type of sink buffers
>> will follow once a foundation has been established.
>>
>> Enhancement to the perf command line tool can be found here [1].
>> It is based on v4.2 but a rebase to v4.3-rcX will be available
>> shortly.
>>
>> Best regards,
>> Mathieu
>>
>> [1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/shortlog/refs/heads/perf-v4.2
>
> I had a peek there -- didn't see an actual decoder for the ETM/PTM
> binary stream or did I miss it somehow?

A stream decoder is not included in this patch set but a couple of
people are currently working on it.

>
> Thanks,
> --
> Alex
