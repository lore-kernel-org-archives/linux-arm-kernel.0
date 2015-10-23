From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 22:00:37 +0200
Subject: [PATCH 0/5] ARM: dts: fix cpu compatible values
In-Reply-To: <5625303C.6090902@mleia.com>
References: <1443202506-13732-1-git-send-email-vz@mleia.com>
 <5625303C.6090902@mleia.com>
Message-ID: <6261588.UmaTDKo2vv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 October 2015 21:02:36 Vladimir Zapolskiy wrote:
> On 25.09.2015 20:35, Vladimir Zapolskiy wrote:
> > The changeset corrects severeal cpu compatible properties
> > to defined ones in Documentation/devicetree/bindings/arm/cpus.txt
> > 
> > Vladimir Zapolskiy (5):
> >   ARM: dts: i.MX31: fix cpu compatible value
> >   ARM: dts: i.MX35: fix cpu compatible value
> 
> Ping. Two patches above are applied by Shawn, could ARM maintainers
> apply the rest? Thank you in advance.
> 

Applied the missing two as well now, thanks for the fixes!

	Arnd
