From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 17 Oct 2015 18:30:57 +0200
Subject: [GIT PULL] Allwinner drivers for 4.4, round 1
In-Reply-To: <6783763.jm4ezqcpgx@wuerfel>
References: <20151011162642.GA11423@lukather>
 <6783763.jm4ezqcpgx@wuerfel>
Message-ID: <20151017163057.GO2711@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Oct 15, 2015 at 10:21:59PM +0200, Arnd Bergmann wrote:
> On Sunday 11 October 2015 17:26:42 Maxime Ripard wrote:
> > ----------------------------------------------------------------
> > Allwinner drivers changes for 4.4
> > 
> > A new driver for the Reduced Serial Bus used in the newer Allwinner SoCs to
> > communicate with the PMIC and other devices made by Allwinner (audio codecs
> > for example)
> > 
> 
> Sorry for a belated complaint here. The code looks absolutely fine,
> isn't this something that should be in drivers/bus/?
> 
> If there is a slight chance that this might be reused on another
> soc family, that would be a better place, but even if it's Allwinner
> specific it feels cleaner that way.

IIRC, Mark suggested drivers/soc, but drivers/bus would be better I
guess.

Chen-Yu, can you send a new version in drivers/bus ?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151017/0a2a3dd4/attachment-0001.sig>
