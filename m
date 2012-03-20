From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Tue, 20 Mar 2012 21:58:07 +0000
Subject: [PATCH v8 0/8] Consolidate cpuidle functionality
In-Reply-To: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
Message-ID: <201203202158.08042.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 March 2012, Robert Lee wrote:
> This patch series moves various functionality duplicated in platform 
> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> disabling was removed as it appears that all calls into 
> cpuidle_call_idle will have already called local_irq_disable().
> 
> These changes have been pulled into linux-next.
> 
> Len, Andrew, can a request be made for Linus to pull these changes?

FWIW, Len seems to be rather inactive on the kernel mailing list right
now and generally not very interested in anything outside of x86 and
acpi. If he doesn't reply in the next few days and Andrew also isn't
interested in handling these patches, I'd suggest you just send the pull
request to Linus, with Len on Cc and explain that you tried to send
them through him but gave up in the end.

	Arnd
