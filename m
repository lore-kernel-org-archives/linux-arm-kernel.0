From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Jul 2012 04:07:31 -0600 (MDT)
Subject: Current state of AM33xx patches
In-Reply-To: <4FEEC7F2.8070507@gmail.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com>
 <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com>
 <4FE9A00B.6010908@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
 <4FEC7394.9030208@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com>
 <4FEDF54D.4030609@gmail.com>
 <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com>
 <4FEEC7F2.8070507@gmail.com>
Message-ID: <alpine.DEB.2.00.1207040403010.6760@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 30 Jun 2012, Daniel Mack wrote:

> Ok, thanks for the explaining this. For now, I'll add hwmod stubs for
> the components I need.

Hmm.  Which drivers are you working on?  Vaibhav Hiremath has hwmod data 
for the AM33xx.  There might be some missing integration code to build the 
devices for the newer IP blocks, though.

> Btw, has anyone yet worked on getting the MDIO/EMAC driver merged?

Mainline has:

drivers/net/ethernet/ti/davinci_emac.c
drivers/net/ethernet/ti/davinci_mdio.c

Those might work for you.


- Paul
