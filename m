From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 30 Mar 2017 21:51:45 +0800
Subject: [PATCH v5 6/9] coresight: add support for CPU debug module
In-Reply-To: <a9078a4e-152e-01ae-8750-1396da2bc623@arm.com>
References: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
 <1490466197-29163-7-git-send-email-leo.yan@linaro.org>
 <20170328165010.GA21937@linaro.org>
 <20170329015423.GA5035@leoy-linaro>
 <CAJ9a7VhQRuVOCJkjPc9RANGo=fgA8wjtB65dC5f19ZX22a5FHQ@mail.gmail.com>
 <20170330010343.GA31843@leoy-linaro>
 <a9078a4e-152e-01ae-8750-1396da2bc623@arm.com>
Message-ID: <20170330135145.GA26911@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 10:00:30AM +0100, Suzuki K Poulose wrote:

[...]

> Leo,
> 
> Also, it would be good to restore the PRCR register back to the original state
> after we read the registers (if we changed them). I am exploring ways to make
> use of this feature on demand (e.g, tie it to sysrq-t or sysrq-l) and not just
> at panic time. So it would be good to have the state restored to not affect the
> normal functioning even after dumping the registers.

Got it. Will take care for this.

Thanks,
Leo Yan

> PS: I have a small hack to hook this into a sysrq-x at runtime, but on a second thought
> it is better not to consume the key and rather tie it to something which already exist,
> as mentioned above.
> 
> Thanks
> Suzuki
