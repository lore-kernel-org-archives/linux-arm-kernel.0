From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2015 23:33:55 +0000
Subject: [PATCH v7 0/4] ARM SMC Calling Convention interface
In-Reply-To: <201512222320.25222.arnd@arndb.de>
References: <1450795956-18223-1-git-send-email-jens.wiklander@linaro.org>
 <201512222320.25222.arnd@arndb.de>
Message-ID: <20151222233355.GP8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 11:20:25PM +0100, Arnd Bergmann wrote:
> On Tuesday 22 December 2015, Jens Wiklander wrote:
> > This patch set is based on the Generic TEE subsystem v6 patchset
> > (https://lwn.net/Articles/662495/) sent out a some time ago. By isolating
> > the ARM SMC Calling Convention patches that are useful for other purposes
> > than to support the Generic TEE subsystem some complexity is removed from
> > that patch set.
> > 
> > This patch set adds a common interface to do an SMC or HVC following ARM
> > SMC Calling Convention. The interface is implemented for both the arm and
> > arm64 architectures and updates the PSCI driver to use this interface
> > instead for firmware communication.
> > 
> > Kevins previous Tested-by tag isn't included as the changes in the config
> > variables may affect some of the builds.
> 
> I see that you have a lot of people addressed as 'To', which usually
> means that nobody is going to apply the patches, because none of us knows
> who should be responsible ;-)
> 
> Is the plan still for Russell to pick them up in his tree? Please clarify
> in the introductory mail what you would like to happen (more review, 
> apply to some tree, get Acks, ...) and change the recipient list accordingly.

That is the plan as they are core ARM functionality, but it's now too
late for them to be applied prior to Christmas and the merge window.
My tree is now closed to new submissions for Christmas.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
