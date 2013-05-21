From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 21 May 2013 19:38:38 +1000
Subject: [RFC PATCH v3] drivers: bus: add ARM CCI support
In-Reply-To: <20130521092119.GA1885@e102568-lin.cambridge.arm.com>
References: <1368095640-3675-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368095640-3675-2-git-send-email-lorenzo.pieralisi@arm.com>
 <1369051881.3511.4.camel@linaro1.home>
 <20130521092119.GA1885@e102568-lin.cambridge.arm.com>
Message-ID: <1369129118.6387.61.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-05-21 at 10:21 +0100, Lorenzo Pieralisi wrote:
> The node name, not type, but point is taken. I prefer to add a
> compatible property to slave-if nodes (eg "arm,cci-400-control-if"),
> I do not think that checking the node name is the standard way of
> doing
> things in DT world.
> 
> Thoughts ?

Agreed.

Cheers,
Ben.
