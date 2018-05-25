From: horms@verge.net.au (Simon Horman)
Date: Fri, 25 May 2018 12:09:09 +0200
Subject: [PATCH] ARM: dts: porter: Add missing PMIC nodes
In-Reply-To: <CAMuHMdVCPEChhbHsc1Tcp-zkBY5v8Mz+8qq-v3GVFifL_uLyeA@mail.gmail.com>
References: <20180523114340.10216-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVCPEChhbHsc1Tcp-zkBY5v8Mz+8qq-v3GVFifL_uLyeA@mail.gmail.com>
Message-ID: <20180525100908.wybt74b5l4wro4gb@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 01:52:32PM +0200, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Wed, May 23, 2018 at 1:43 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Add PMIC nodes to Porter and connect CPU DVFS supply. There is
> > one DA9063L and one DA9210 on Porter, the only difference from
> > the other boards is that DA9063L is at I2C address 0x5a rather
> > than 0x58 .
> 
> Ah, so porter needs the regulator quirk, too.
> 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
