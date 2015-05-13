From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 11:17:07 +0200
Subject: [PATCH v7 0/4] ARM: SoC: add a new platform,
 UniPhier (arch/arm/mach-uniphier)
In-Reply-To: <20150513083234.GP2558@tarshish>
References: <1431058034-5508-1-git-send-email-yamada.masahiro@socionext.com>
 <2230140.n6kW8LSSaP@wuerfel> <20150513083234.GP2558@tarshish>
Message-ID: <12079182.VTh0Y5GzSg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 11:32:34 Baruch Siach wrote:
> Hi Arnd,
> 
> On Wed, May 13, 2015 at 09:48:33AM +0200, Arnd Bergmann wrote:
> > For sending pull requests, it would be good to have a gpg key that
> > is signed by other well-known kernel developers. If you have such
> > a key, you can also request a kernel.org account to host a git tree
> > there, or you can host a git tree somewhere on your company's domain.
> > A public hosting service like github is not as good for us, but we
> > can deal with it when you are still ramping up your infrastructure.
> > Let me know if you need help finding kernel developers to sign your key.
> 
> Is a pull request from a kernel.org repo trusted more than the key itself? In 
> other words, if I sign my pull request with a trusted key, why would the git 
> repo location make any difference?

The main advantage is higher confidence I have in your pull request if I
don't look at the signature, because I can assume that someone else already
did when you got your account.

	Arnd
