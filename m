From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Feb 2013 20:34:33 +0000
Subject: [PATCH 09/17] ARM: add atag32_to_cpu() function
In-Reply-To: <20130212184636.GJ30595@game.jcrosoft.org>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-10-git-send-email-ben.dooks@codethink.co.uk>
 <20130209120331.GC17833@n2100.arm.linux.org.uk>
 <51194347.9090501@codethink.co.uk> <20130212184636.GJ30595@game.jcrosoft.org>
Message-ID: <20130212203433.GW17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 07:46:36PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> I run the ixp in be
> 
> and pass the atag in be

So that would be "native endian" then.
