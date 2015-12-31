From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Dec 2015 14:21:16 +0100
Subject: [PATCH RFC] ARM: tango4: Fix build issues
In-Reply-To: <567DBA04.4060709@free.fr>
References: <567DBA04.4060709@free.fr>
Message-ID: <20151231132116.GB1547@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 25, 2015 at 10:49:56PM +0100, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> Move SMP setup to platsmp.c
> Specify the CPU type to the assembler, and only for smc.S
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---

Applied, thanks.


-Olof
