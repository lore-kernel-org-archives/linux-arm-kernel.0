From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 22 Dec 2015 21:17:22 -0800
Subject: [PATCH v7 0/4] ARM SMC Calling Convention interface
In-Reply-To: <1450795956-18223-1-git-send-email-jens.wiklander@linaro.org>
 (Jens Wiklander's message of "Tue, 22 Dec 2015 15:52:32 +0100")
References: <1450795956-18223-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <7hfuytspzx.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jens Wiklander <jens.wiklander@linaro.org> writes:

> This patch set is based on the Generic TEE subsystem v6 patchset
> (https://lwn.net/Articles/662495/) sent out a some time ago. By isolating
> the ARM SMC Calling Convention patches that are useful for other purposes
> than to support the Generic TEE subsystem some complexity is removed from
> that patch set.
>
> This patch set adds a common interface to do an SMC or HVC following ARM
> SMC Calling Convention. The interface is implemented for both the arm and
> arm64 architectures and updates the PSCI driver to use this interface
> instead for firmware communication.
>
> Kevins previous Tested-by tag isn't included as the changes in the config
> variables may affect some of the builds.

OK, I applied this on top of v4.4-rc6 and pushed it through another
round of build[1] and boot[2] testing and things look fine.

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin

[1] https://kernelci.org/build/arm-soc/kernel/v4.4-rc6-4-g1ab3cf17f5bd/
[2] https://kernelci.org/boot/all/job/arm-soc/kernel/v4.4-rc6-4-g1ab3cf17f5bd/
