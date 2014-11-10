From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 10 Nov 2014 09:58:59 +0100
Subject: linux-next: manual merge of the mmc-uh tree with the arm-soc tree
In-Reply-To: <20141110125637.30fe73b9@canb.auug.org.au>
References: <20141110125637.30fe73b9@canb.auug.org.au>
Message-ID: <54607E53.4060105@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2014 02:56, Stephen Rothwell :
> Hi Ulf,
> 
> Today's linux-next merge of the mmc-uh tree got a conflict in
> arch/arm/mach-at91/at91sam9g45_devices.c between commit 4bf7753b8ab7
> ("ARM: at91: remove at91sam9g45/9m10 legacy board support") from the
> arm-soc tree and commit 4049854c41e0 ("ARM: at91: remove
> mach/atmel-mci.h") from the mmc-uh tree.
> 
> I fixed it up (I just removed the file) and can carry the fix as
> necessary (no action is required).

Well fixed. Thanks Stephen.

Bye,
-- 
Nicolas Ferre
