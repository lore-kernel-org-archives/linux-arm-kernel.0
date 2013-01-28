From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 28 Jan 2013 12:23:56 +0000
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <20130125165942.GY22517@atomide.com>
References: <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <50FE66AC.2090306@mimc.co.uk>
 <B5906170F1614E41A8A28DE3B8D121433ECF3DD3@DBDE01.ent.ti.com>
 <50FE9692.2090001@mimc.co.uk> <20130122182331.GO22517@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433ECF6261@DBDE01.ent.ti.com>
 <20130125165942.GY22517@atomide.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECFF0CA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 22:29:43, Tony Lindgren wrote:
> * Bedia, Vaibhav <vaibhav.bedia@ti.com> [130123 06:35]:
> > Hi Tony,
> > 
> > On Tue, Jan 22, 2013 at 23:53:32, Tony Lindgren wrote:
> > [...]
> > > > 
> > > > But I should get *something* from the kernel before it starts trying to access the rootfs ?
> > > 
> > > Here's something Kevin fixed but did not send it out before going to
> > > a vacation. Can you give it a try with earlyprintk enabled?
> > > 
> > > Note that this does not help with no output early on, that sounds
> > > like a bug configuring the DEBUG_LL port somewhere.
> > > 
> > 
> > I think earlyprintk on AM335x has not been functional for a while [1].
> > Will the latest patches from you to enable multiplatform debug-ll be sufficient
> > to test this out? I am trying to track down the boot issues reported and just
> > want to be sure of the dependencies. 
> 
> Yes you should check with current linux next and select the DEBUG_LL
> port manually.
>  

Verified on linux-next that selecting the right UART port gives a functional early_console. 
(One of the rare cases where forcing a kernel panic early in the boot process makes sense ;)

Regards,
Vaibhav
