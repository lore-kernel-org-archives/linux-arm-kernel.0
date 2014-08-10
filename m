From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 10 Aug 2014 23:23:45 +0200
Subject: [PATCH 2/6] ARM: mvebu: Add proper pin muxing on Globalscale
 Mirabox board
In-Reply-To: <20140810193826.6c4c02c4@free-electrons.com>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1407511136-26477-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140808171208.GC26751@lunn.ch>
 <20140808182156.GA16889@arch.cereza>
 <20140808192106.GD26751@lunn.ch>
 <20140809172149.59f54746@free-electrons.com>
 <20140809155756.GB5427@titan.lakedaemon.net>
 <20140810193826.6c4c02c4@free-electrons.com>
Message-ID: <20140810212345.GH26751@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> However, Andrew was suggesting to move the phandle selection to
> the .dtsi file, with the argument that most boards use RGMII, so it
> should be the default. That's what I disagreed with.

I'm not too bothered. So place it in the board .dts file.

    Andrew
