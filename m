From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Dec 2013 22:56:59 +0100
Subject: [PATCH v4 2/2] ARM: sun4i/sun7i: RTC driver
In-Reply-To: <CAOQ7t2bo0uDfs+1eUZRVD6agk3BSuUNw=C7OEEzyTEa-QYto2g@mail.gmail.com>
References: <1384623234-9334-1-git-send-email-carlo.caione@gmail.com>
 <1384623234-9334-2-git-send-email-carlo.caione@gmail.com>
 <CAOQ7t2bo0uDfs+1eUZRVD6agk3BSuUNw=C7OEEzyTEa-QYto2g@mail.gmail.com>
Message-ID: <20131220215659.GE3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

On Mon, Dec 09, 2013 at 04:34:37PM +0100, Carlo Caione wrote:
> On Sat, Nov 16, 2013 at 6:33 PM, Carlo Caione <carlo.caione@gmail.com> wrote:
> > This patch introduces the driver for the RTC in the Allwinner A10 and
> > A20 SoCs.
> >
> > Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
> > --
> > v3->v4:
> > - several bug fixes
> > - reworked for cycles
> > - implemented busy-waiting
> > - new macro for year offset
> > - new comments
> 
> Ping?

I just merged the two patches in the sunxi/drivers-for-3.14 branch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/36291172/attachment.sig>
