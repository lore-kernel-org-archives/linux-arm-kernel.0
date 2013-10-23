From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 23 Oct 2013 10:02:11 -0400 (EDT)
Subject: [PATCH] ARM: bL_switcher: Remove
 cpu_hotplug_driver_{lock,unlock}()
In-Reply-To: <1382522073-14995-1-git-send-email-tushar.behera@linaro.org>
References: <1382522073-14995-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <alpine.LFD.2.03.1310231001180.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Oct 2013, Tushar Behera wrote:

> Commit 6dedcca610c6 ("hotplug, powerpc, x86: Remove
> cpu_hotplug_driver_lock())" removes the the definition of
> cpu_hotplug_driver_{lock,unlock} APIs, thereby causing a build error.

Where is this commit to be found?


Nicolas
