From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Jul 2016 16:01:50 +0200
Subject: [PATCH v0 00/10] Convert Netgear WNR854T to devicetree
In-Reply-To: <alpine.DEB.2.11.1607190933590.19980@marmot.wormnet.eu>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <20160716205304.GA5075@lunn.ch>
 <alpine.DEB.2.11.1607171043100.19980@marmot.wormnet.eu>
 <20160717153338.GA13611@lunn.ch>
 <alpine.DEB.2.11.1607190933590.19980@marmot.wormnet.eu>
Message-ID: <20160719140150.GY31103@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> However, the ethertype is reflecting the port:-
> 
> lan1/5 : ethertype Unknown (0xc028), length 176:
> lan2/7 : ethertype Unknown (0xc038), length 176:
> lan3/0 : ethertype Unknown (0xc000), length 176:
> lan4/1 : ethertype Unknown (0xc008), length 176:
> wan/2  : ethertype Unknown (0xc010), length 176:
> 
> My other one of these routers, running OpenWRT / Linux 3.3.8, shows
> the same ethertypes, which suggests that the switch is still in DSA
> tagging mode. I'll poke around further and see what I find.

O.K. With this wrong, nothing is going to work.

I will check that the 6131 actually supports EDSA!

  Andrew
