From: schindele@nentec.de (Juergen Schindele)
Date: Thu, 17 Sep 2009 09:35:31 +0200
Subject: Problems with pthread on ARM/PXA270
In-Reply-To: <f17812d70909160806l5e4ce5e9t4c7cfea5ca714b91@mail.gmail.com>
References: <200909160926.02036.schindele@nentec.de>
	<200909161701.16898.schindele@nentec.de>
	<f17812d70909160806l5e4ce5e9t4c7cfea5ca714b91@mail.gmail.com>
Message-ID: <200909170935.31570.schindele@nentec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 16. September 2009 schrieb Eric Miao:
> On Wed, Sep 16, 2009 at 11:01 PM, Juergen Schindele <schindele@nentec.de> wrote:
> > Am Mittwoch, 16. September 2009 schrieb Eric Miao:
> >> Don't remember we had such problems before. What kind of system
> >> and libraries are you using?
> > thanks for your reply.
> > System is custom PXA270 platform.
> > with codesourcery compiler (see below)
> > and glibc 2.5 with pthread.
> > I dont know what more information to give ?
> 
> Like which kernel version, where do you get the glibc-2.5 and pthread binary,
Sorry forgot that completely !
Kernel version tested is 2.6.16 and 2.6.20 (sorry no newer version available yet)
Compiler , GlibC, pthread all come from Codesourcery precompiled in a package
 "CodeSourcery Sourcery G++ Lite 2007q1-10" downloadable for free.
Compiler version is as mentioned before :
arm-none-linux-gnueabi-gcc (CodeSourcery Sourcery G++ Lite 2007q1-10) 4.2.0 20070413 (prerelease)
 
--------------------------------------------------------------
J?rgen Schindele  
Software-Entwicklung

NENTEC Netzwerktechnologie GmbH
Greschbachstr. 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
E-Mail:  schindele at nentec.de
WEB:     www.nentec.de
 
Gesch?ftsf?hrung: Klaus Becker, Roland Knapp
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658
--------------------------------------------------------------
