From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 20 Sep 2010 12:44:50 -0700
Subject: [PATCH v3] davinci: MityDSP-L138/MityARM-1808 read MAC address
	from I2C Prom
In-Reply-To: <1284731766-2751-1-git-send-email-michael.williamson@criticallink.com>
	(Michael Williamson's message of "Fri, 17 Sep 2010 09:56:06 -0400")
References: <1284731766-2751-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <87k4mgurm5.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Williamson <michael.williamson@criticallink.com> writes:

> For the MityDSP-L138/MityARM-1808 SOMS, read the factory assigned
> MAC address from the onboard I2C EPROM and assign it to the emac
> device during platform initialization.
>
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> ---
> Patch is against e90c3a5344683351c7a37f097f1e17d50ee2063c of linux-davinci 
> tree.
>
> Changes since v2:
> 	1) removed 8 bytes of &'s and [0]'s from &foo[0]'s per comments

Thanks.

Applying and queuing for 2.6.37 in davinci-next.

Kevin
 
