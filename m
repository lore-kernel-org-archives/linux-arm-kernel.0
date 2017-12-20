From: w@1wt.eu (Willy Tarreau)
Date: Wed, 20 Dec 2017 06:19:51 +0100
Subject: [PATCH net 0/3] Few mvneta fixes
In-Reply-To: <CAK8P3a18h_JB_P4DOFmd+v+f5KM1X9h513qUke_7nxoSJtiOUw@mail.gmail.com>
References: <20171219165947.28516-1-gregory.clement@free-electrons.com>
 <CAK8P3a18h_JB_P4DOFmd+v+f5KM1X9h513qUke_7nxoSJtiOUw@mail.gmail.com>
Message-ID: <20171220051951.GA8421@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Dec 19, 2017 at 09:18:35PM +0100, Arnd Bergmann wrote:
> On Tue, Dec 19, 2017 at 5:59 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
> > Hello,
> >
> > here it is a small series of fixes found on the mvneta driver. They
> > had been already used in the vendor kernel and are now ported to
> > mainline.
> 
> Does one of the patches look like it addresses the rare Oops we discussed on
> #kernelci this morning?
> 
> https://storage.kernelci.org/stable/linux-4.9.y/v4.9.70/arm/mvebu_v7_defconfig/lab-free-electrons/boot-armada-375-db.html

I could be wrong but for me the 375 uses mvpp2, not mvneta, so this
should have no effect there.

Willy
