From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 23 Oct 2013 11:11:19 -0400 (EDT)
Subject: [PATCH] ARM: bL_switcher: Remove
 cpu_hotplug_driver_{lock,unlock}()
In-Reply-To: <1382522073-14995-1-git-send-email-tushar.behera@linaro.org>
References: <1382522073-14995-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <alpine.LFD.2.03.1310231108300.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Oct 2013, Tushar Behera wrote:

> Commit 6dedcca610c6 ("hotplug, powerpc, x86: Remove
> cpu_hotplug_driver_lock())" removes the the definition of
> cpu_hotplug_driver_{lock,unlock} APIs, thereby causing a build error.
> 
> Replace these calls with {lock,unlock}_device_hotplug().
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>

About this patch:

Acked-by: Nicolas Pitre <nico@linaro.org>

However I'd like to have confirmation of the commit 6dedcca610c6 
location so it is actually what will reach mainline.


Nicolas
