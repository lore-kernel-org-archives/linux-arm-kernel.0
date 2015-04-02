From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 2 Apr 2015 17:33:51 +0200
Subject: [PATCH] ARM: mvebu: use 0xf1000000 as internal registers on
 Armada 370 DB
In-Reply-To: <551D61CB.6000008@free-electrons.com>
References: <1427966184-8288-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <2321040.CmsL1gluUd@wuerfel>
 <20150402153650.2cc9c3d7@free-electrons.com>
 <2515980.d69ggAvHPo@wuerfel>
 <20150402161626.182e267d@free-electrons.com>
 <551D61CB.6000008@free-electrons.com>
Message-ID: <20150402153351.GI10092@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> As Andrew and Jason seem also agree with this patch, I would like to apply
> on it on the mvebu tree. However there is no point to do it if at the end
> you won't take it. Given the new information given by Thomas, do you agree
> with this patch?

It seems like Thomas should maybe include some of this discussion in
the changelog, just to add a bit more justification.

    Andrew
