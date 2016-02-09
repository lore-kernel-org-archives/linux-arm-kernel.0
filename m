From: slash.tmp@free.fr (Mason)
Date: Tue, 9 Feb 2016 11:17:48 +0100
Subject: [PATCH RFC] Add cpufreq support
In-Reply-To: <7910928.pmJjZiV1Lk@wuerfel>
References: <56B4D4BE.2040008@free.fr> <22002072.L04zy0K2AP@wuerfel>
 <20160208131625.GI8294@vireshk> <7910928.pmJjZiV1Lk@wuerfel>
Message-ID: <56B9BCCC.8060404@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2016 14:45, Arnd Bergmann wrote:

> That's why I said we could introduce a 'v3' with the meaning
> it should have had to start with: compatible means actually
> compatible with the driver.

If I understand correctly, something needs to change in the
framework before I can push cpufreq support for my platform
upstream, correct?

Could you CC me if anything happens on that front?

In my local 4.4 branch, I think I should use whatever method
was recommended at the time.

Was that to define the platform's init_late method, and call
platform_device_register_simple from there? (Could you take
a quick glance at the patch, and see if it is acceptable in
the context of kernel 4.4?)

Regards.
