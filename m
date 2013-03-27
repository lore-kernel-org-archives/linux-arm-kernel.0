From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 01:52:51 +0100
Subject: [PATCH 3/6] ARM: remove fa526 CPU support
In-Reply-To: <8978419.396TjzrzY0@flatron>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <201303181116.17369.arnd@arndb.de> <8978419.396TjzrzY0@flatron>
Message-ID: <1446859.f6dxOfhkOT@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 of March 2013 21:11:33 Tomasz Figa wrote:
> On Monday 18 of March 2013 11:16:17 Arnd Bergmann wrote:
> > On Monday 18 March 2013, Jonas Jensen wrote:
> > > On 15 March 2013 13:49, Florian Fainelli <florian@openwrt.org> 
wrote:
> > > > Someone recently announced support for a Moxart SoC which seems to
> > > > use the FA526 core however.
> > > 
> > > That was probably me, and I understand people want it gone. Even
> > > Debian wants v4:s gone because they're not strictly EABI (
> > > http://lists.debian.org/debian-arm/2010/12/msg00044.html ).
> > 
> > It's not that we want it gone, it si that we want unmaintained code
> > to be removed. ARMv4 support is going to stay at least for a couple
> > more years, probably longer given the number of ARM7TDMI and StrongARM
> > systems still in use.
> > 
> > There are probably no general purpose distros that will build for
> > ARMv4 any more, but a lot of the embedded distros (OpenWRT,
> > OpenEmbedded, Buildroot, ...) typically build all user space from
> > source anyway, so there is no issue.
> > 
> > > The port is not near mainline but I think I'd prefer if CPU_FA526
> > > wasn't removed. If someone stepped up to maintain ARCH_GEMINI (so I
> > > could peek at the changes) that would be even better :)
> > 
> > I've tried before to find someone who is still interested in Gemini,
> > but it seems nobody has the hardware any more.
> 
> I should still have a SquareOne SQ201 (Gemini-based NAS/router/WLAN AP)
> somewhere. However I doubt that I will be able to find time to do
> anything with it anytime soon, so I can give it to someone willing to
> do something with Gemini platform in mainline. (I would prefer someone
> from EU, though, as here in Poland the cost of sending anything outside
> the EU is awfully high...).

Already taken by Florian. Good that it will finally find some use after 
spending several years in a cabinet.

Best regards,
Tomasz
