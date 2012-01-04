From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 4 Jan 2012 18:27:29 +0100
Subject: [PATCH 0/3] coupled cpuidle state support
In-Reply-To: <87sjjw70zs.fsf@ti.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
 <87sjjw70zs.fsf@ti.com>
Message-ID: <CAMQu2gwsw+RC+Y9P8r9Yjy+ADuQ-tPzcXPPncLxMjjb3tvdbbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 1:41 AM, Kevin Hilman <khilman@ti.com> wrote:
> Colin Cross <ccross@android.com> writes:
>
>
>> This patch series implements an alternative solution, where each
>> cpu will wait in the WFI state until all cpus are ready to enter
>> a coupled state, at which point the coupled state function will
>> be called on all cpus at approximately the same time.
>
> This looks great, and is certainly preferred to hotplug IMO.
>
> [...]
>
>> None of the platforms I work with have an SMP idle implementation
>> upstream, so I can't easily show a patch that converts a platform
>> from hotplug governor to coupled cpuidle states.
>
> Basic OMAP4 CPUidle support is in now queued for v3.3 (see omap4
> branch Tony's tree[1].)
>
> Can you (or Santosh) send a patch that adds coupled support to that
> driver so it can see some broader testing on OMAP4?
>
I briefly attempted OMAP4 idle with this series but had some lock
up related issues which we faced in the older development.

Then I got busy into other activities which will keep me occupied for
next few weeks. I will be happy to share the patches in case some one
would like to have a look till then.

Regards
Santosh
