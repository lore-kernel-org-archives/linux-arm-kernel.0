From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 May 2014 13:04:02 +0200
Subject: [RFC] Sort out S5P SoCs support in mainline
In-Reply-To: <021f01cf7a61$69853e30$3c8fba90$@samsung.com>
References: <021f01cf7a61$69853e30$3c8fba90$@samsung.com>
Message-ID: <13875033.1X6R9lksgc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 May 2014 19:41:41 Kukjin Kim wrote:
> Hi all,
> 
> I'm wondering who need to support following SoCs/boards in mainline.
> 
> * S5P64X0/SMDK6440 and SMDK6450
> * S5PC100/SMDKC100
> 
> If nobody is using them, how about to remove them from mainline?

I talked about this with Tomasz Figa before, he also thinks they can be removed.
I don't see any reason to keep them myself, and will apply a patch to remove
them. Of course, if later somebody comes around who does need them, we can
revert the patch to bring them back.

	Arnd
