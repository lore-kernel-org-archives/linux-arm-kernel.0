From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Dec 2017 21:18:35 +0100
Subject: [PATCH net 0/3] Few mvneta fixes
In-Reply-To: <20171219165947.28516-1-gregory.clement@free-electrons.com>
References: <20171219165947.28516-1-gregory.clement@free-electrons.com>
Message-ID: <CAK8P3a18h_JB_P4DOFmd+v+f5KM1X9h513qUke_7nxoSJtiOUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 5:59 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hello,
>
> here it is a small series of fixes found on the mvneta driver. They
> had been already used in the vendor kernel and are now ported to
> mainline.

Does one of the patches look like it addresses the rare Oops we discussed on
#kernelci this morning?

https://storage.kernelci.org/stable/linux-4.9.y/v4.9.70/arm/mvebu_v7_defconfig/lab-free-electrons/boot-armada-375-db.html

          Arnd
