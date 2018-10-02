From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 2 Oct 2018 11:28:16 +0200
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.20
In-Reply-To: <CAK8P3a3qoz2rY2PLxBpLpr+7uFD9jwbWNAipD4RNC1bH9b9b_Q@mail.gmail.com>
References: <20180929145659.73sto3j7235jg6b6@flea>
 <CAK8P3a3qoz2rY2PLxBpLpr+7uFD9jwbWNAipD4RNC1bH9b9b_Q@mail.gmail.com>
Message-ID: <20181002092816.g42dlxegxm7j7qjk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 11:02:21AM +0200, Arnd Bergmann wrote:
> On Sat, Sep 29, 2018 at 4:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> 
> > ----------------------------------------------------------------
> > Allwinner arm64 DT changes for 4.20
> >
> > Our usual set of DT changes for the arm64 Allwinner SoCs.
> >
> > The most notable things are:
> >   - HDMI support on the A64
> >   - New boards: OrangePi One Plus
> 
> I just had a look at the OrangePi One Plus, that seems to be a particularly
> nice combination of low price and (possibly) low power consumption with
> the 28nm CPU and LPDDR3 memory. How well does it work in practice?

The support is really early at that point. There's basically only
support for the UART and the MMC, but it definitely looks promising :)

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181002/32056b98/attachment.sig>
