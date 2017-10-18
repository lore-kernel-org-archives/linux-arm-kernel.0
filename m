From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Oct 2017 12:09:36 +0100
Subject: [PATCH v4 07/13] firmware: arm_sdei: Add driver for Software
 Delegated Exceptions
In-Reply-To: <20171017174432.1684-8-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171017174432.1684-8-james.morse@arm.com>
Message-ID: <20171018110935.yrvvonyjlrj7cqi2@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 06:44:26PM +0100, James Morse wrote:
> The Software Delegated Exception Interface (SDEI) is an ARM standard
> for registering callbacks from the platform firmware into the OS.
> This is typically used to implement firmware notifications (such as
> firmware-first RAS) or promote an IRQ that has been promoted to a
> firmware-assisted NMI.
> 
> Add the code for detecting the SDEI version and the framework for
> registering and unregistering events. Subsequent patches will add the
> arch-specific backend code and the necessary power management hooks.
> 
> Only shared events are supported, power management, private events and
> discovery for ACPI systems will be added by later patches.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
