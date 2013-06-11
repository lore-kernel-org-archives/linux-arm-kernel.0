From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 11 Jun 2013 19:31:21 +0200
Subject: [PATCH 3/3] ARM: dts: OMAP3: Use MTD constants for OMAP3 boards
In-Reply-To: <51B74FEE.1010301@wwwdotorg.org>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
 <1370962138-9631-4-git-send-email-florian.vaussard@epfl.ch>
 <51B74FEE.1010301@wwwdotorg.org>
Message-ID: <51B75EE9.9050901@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 06/11/2013 06:27 PM, Stephen Warren wrote:
> On 06/11/2013 08:48 AM, Florian Vaussard wrote:
>> Use the MTD constants for NAND and OneNAND nodes used in OMAP3
>> DTS.
>
> I don't quite understand the split between patches 2/3 and 3/3; isn't
> the edit to omap3-overo.dtsi (part of) a board file, and hence logically
> part of this patch? I'd be tempted just to squash the two together.
>
> But, this is a nit; not a big deal.
>

Patch 2/3 was adding a new node, whereas patch 3/3 was converting existing
nodes. But your point is perfectly valid.

Regards,

Florian
