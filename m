From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 1 Oct 2015 16:12:44 -0600
Subject: [RFC PATCH 00/20] Coresight integration with perf
In-Reply-To: <87wpv8jn6n.fsf@ashishki-desk.ger.corp.intel.com>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
 <87wpv8jn6n.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkxmYb+=PKmpY7pAFU+zkCNdKWXEjoCAQbELY9jRcpGA+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2015 at 03:01, Alexander Shishkin
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
>
> Also this patchset doesn't seem to apply to tip/perf/core, v4.3-rc3,
> v4.2. What is it based on? Do you have a git branch with these patches
> as well?

The kernel space portion applied to v4.3-rc1.  I had to keep the user
space side on a private branch based on v4.2 since v4.3-rc1 didn't
have a few fix from Adrian.  V2 will be based on v4.3-rc4 and have all
the patches (user and kernel space) on the same tree.


>
> Regards,
> --
> Alex
