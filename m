From: mylene.josserand@bootlin.com (=?UTF-8?B?TXlsw6huZQ==?= Josserand)
Date: Sun, 25 Feb 2018 16:20:19 +0100
Subject: [PATCH v4 02/10] ARM: sun9i: smp: Rename clusters's power-off
 register
In-Reply-To: <20180223145650.dzhdhh2cprqioq5m@flea.lan>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-3-mylene.josserand@bootlin.com>
 <20180223145650.dzhdhh2cprqioq5m@flea.lan>
Message-ID: <20180225162019.3b2ae153@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 23 Feb 2018 15:56:50 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Fri, Feb 23, 2018 at 02:37:34PM +0100, Myl?ne Josserand wrote:
> > To prepare the support for sun8i-a83t, rename the variable name
> > that handles the power-off of clusters because it is different from
> > sun9i-a80 to sun8i-a83t.
> >
> > The power off register for clusters are different from SUN9I and SUN8I  
> 
> This is just a nitpick, and I see you use them everywhere, but sun8i
> and sun9i are the family of SoCs, and A80 and A83t the name of SoCs
> within their respective families.
> 
> So in your commit log, you want to support the A83t because it's
> different than the A80, and the sun9i and sun8i mentionned in your
> last sentence is not really meaningful.

True, I will pay attention next time.

> 
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>  
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Maxime
> 

Thanks,

Myl?ne

-- 
Myl?ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
