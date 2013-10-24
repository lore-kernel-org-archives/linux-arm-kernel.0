From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 24 Oct 2013 08:46:49 +0530
Subject: [PATCH] ARM: bL_switcher: Remove cpu_hotplug_driver_{lock,
 unlock}()
In-Reply-To: <alpine.LFD.2.03.1310231108300.1951@syhkavp.arg>
References: <1382522073-14995-1-git-send-email-tushar.behera@linaro.org>
 <alpine.LFD.2.03.1310231108300.1951@syhkavp.arg>
Message-ID: <CAHbNUh3h9QWgNi6Kt4AYX_7pGVY9oeJ-oF0TmFD0jah2TRX7kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 October 2013 20:41, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 23 Oct 2013, Tushar Behera wrote:
>
>> Commit 6dedcca610c6 ("hotplug, powerpc, x86: Remove
>> cpu_hotplug_driver_lock())" removes the the definition of
>> cpu_hotplug_driver_{lock,unlock} APIs, thereby causing a build error.
>>
>> Replace these calls with {lock,unlock}_device_hotplug().
>>
>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>
> About this patch:
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
>
> However I'd like to have confirmation of the commit 6dedcca610c6
> location so it is actually what will reach mainline.
>
>
> Nicolas

The commit is present in Rafael's linux-pm tree which gets included in
linux-next branch. Adding Rafael to the loop for confirmation on the
commit ID.

-- 
Tushar Behera
