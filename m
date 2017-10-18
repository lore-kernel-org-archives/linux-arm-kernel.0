From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Oct 2017 18:16:15 +0100
Subject: [PATCH v4 00/13] arm64/firmware: Software Delegated Exception
 Interface
In-Reply-To: <20171017174432.1684-1-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
Message-ID: <20171018171615.GH21820@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Tue, Oct 17, 2017 at 06:44:19PM +0100, James Morse wrote:
> The Software Delegated Exception Interface (SDEI) is an ARM specification
> for registering callbacks from the platform firmware into the OS.
> This is intended to be used to implement firmware-first RAS notifications,
> but also supports vendor-defined events and binding IRQs as events.
> 
> The document is here:
> http://infocenter.arm.com/help/topic/com.arm.doc.den0054a/ARM_DEN0054A_Software_Delegated_Exception_Interface.pdf
> 
> I anticpate once reviewed this series will go via the arm-soc tree, as the
> bulk of the code is under /drivers/firmware/.

Given the close coupling with the arch code, I'm actually fine taking this
all via arm64 so save it being spread across two merge windows. The driver
code is a new file, so the scope for conflicts is minimal.

Will
