From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Apr 2013 12:43:51 +0100
Subject: [PATCH v3 20/32] arm64: KVM: Plug the arch timer
In-Reply-To: <20130423230024.GH20569@gmail.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-21-git-send-email-marc.zyngier@arm.com>
 <20130423230024.GH20569@gmail.com>
Message-ID: <5177C577.2050209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/13 00:00, Christoffer Dall wrote:
> On Mon, Apr 08, 2013 at 05:17:22PM +0100, Marc Zyngier wrote:
>> Add support for the in-kernel timer emulation. The include file
>> is a complete duplicate of the 32bit one - something to fix
>> at one point.
> 
> again, I'd really like to see this fixed before we merge the code...

Feel free to suggest a solution. None of the one I tried are nice.

	M.
-- 
Jazz is not dead. It just smells funny...
