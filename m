From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Fri, 4 Apr 2014 15:01:06 -0700
Subject: [PATCH RFC v5 3/3] Documentation: arm: define DT idle states
 bindings
In-Reply-To: <20140404155622.GA4061@e102568-lin.cambridge.arm.com>
References: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395142132-20788-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140404155622.GA4061@e102568-lin.cambridge.arm.com>
Message-ID: <CADHgK6v-t69qLYTcez+m2rE1tRecVsKfgwDdPrNPJOKPbmL-nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

I like this :)

I was going to suggest linking the tree upside down (starting with the
leaves such that walking the list takes you back to the root node
(system sleep), but I don't think it matters as long as the
relationship is established (which this does).  I tend to think of
these states in that order, starting from the leaf(shallowest idle
state) and working back to the root(system sleep) since it provides a
simple linear view of the sleep states from the cpu perspective, yet
keeps the heirarchy.

Sebastian
