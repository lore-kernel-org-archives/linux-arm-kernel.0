From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 May 2017 16:28:01 +0200
Subject: [PATCH 6/6] arm64: dts: marvell: enable GICP and ICU on Armada
 7K/8K
In-Reply-To: <1fb18947-33e8-abc9-e78f-970e702af3ee@arm.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <1fb18947-33e8-abc9-e78f-970e702af3ee@arm.com>
Message-ID: <20170530162801.282302f1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 May 2017 15:02:34 +0100, Marc Zyngier wrote:

> > @@ -221,13 +229,13 @@
> >  			cps_crypto: crypto at 800000 {
> >  				compatible = "inside-secure,safexcel-eip197";
> >  				reg = <0x800000 0x200000>;
> > -				interrupts = <GIC_SPI 34 (IRQ_TYPE_EDGE_RISING
> > +				interrupts = <ICU_GRP_NSR 87 (IRQ_TYPE_EDGE_RISING
> >  				| IRQ_TYPE_LEVEL_HIGH)>,  
> 
> I've already mentioned this in a separate thread to Antoine, but it'd be
> good to fix this non-sensical configuration.

Antoine has already submitted a patch, and it has been merged by
Gr?gory already [1]. I simply didn't base my patches on top of the
latest patch from Antoine, but Gr?gory will handle the merge conflict
when applying the DT changes.

Thanks!

Thomas

[1] http://git.infradead.org/linux-mvebu.git/commitdiff/44f73dc42c11398d7b84e94365a485ebd6420798
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
