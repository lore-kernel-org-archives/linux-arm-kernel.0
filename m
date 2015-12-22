From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Dec 2015 23:20:25 +0100
Subject: [PATCH v7 0/4] ARM SMC Calling Convention interface
In-Reply-To: <1450795956-18223-1-git-send-email-jens.wiklander@linaro.org>
References: <1450795956-18223-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <201512222320.25222.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 December 2015, Jens Wiklander wrote:
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

I see that you have a lot of people addressed as 'To', which usually
means that nobody is going to apply the patches, because none of us knows
who should be responsible ;-)

Is the plan still for Russell to pick them up in his tree? Please clarify
in the introductory mail what you would like to happen (more review, 
apply to some tree, get Acks, ...) and change the recipient list accordingly.

	Arnd
