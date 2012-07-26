From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Jul 2012 07:35:51 -0300
Subject: [PATCH v2 2/3] mtd: nand: Let MTD_NAND_GPMI_NAND depend on MXS_DMA
In-Reply-To: <CAMiH66H8GwK+5Zf8RLukC9O35eyQ6rVPYQhV2GarczFYmdpjMA@mail.gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-2-git-send-email-festevam@gmail.com>
 <CAMiH66H8GwK+5Zf8RLukC9O35eyQ6rVPYQhV2GarczFYmdpjMA@mail.gmail.com>
Message-ID: <CAOMZO5Be+t46U=ffA31H=r7f_yLEEOcN+c1UvnFPPYb8hAnYvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 11:27 PM, Huang Shijie <shijie8@gmail.com> wrote:
> I think  we can merget the patch 1 and patch 2 to one patch.

I am not sure on this, as they have clearly different purposes.

Patch 1 fixes the text file and include mx6.

Patch 2 fixes a build issue for mx6.

I prefer to keep them as seperate patches.

Regards,

Fabio Estevam
