From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Jul 2013 20:43:03 +0100
Subject: [RFC PATCH v4 2/2] drivers: mfd: vexpress: add Serial Power
 Controller (SPC) support
In-Reply-To: <20130618102213.GA1564@e102568-lin.cambridge.arm.com>
References: <1371484269-11743-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1371484269-11743-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20130617174451.GF28497@quad.lixom.net>
 <20130618102213.GA1564@e102568-lin.cambridge.arm.com>
Message-ID: <20130703194303.GG27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:22:13AM +0100, Lorenzo Pieralisi wrote:
> On Mon, Jun 17, 2013 at 06:44:51PM +0100, Olof Johansson wrote:

> > That'll trim down the driver to a point where I think you'll find it much
> > easier to get merged. :-)

> To start with I have to understand in which directory this code should
> live. Moving the frequency settings in clk/CPUfreq drivers should be
> feasible with extra DT complexity for their bindings.

You shoudn't really need to change the DT bindings at all - MFD is a
purely Linux construct, it doesn't affect how the hardware is
constructed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/267f48d3/attachment.sig>
