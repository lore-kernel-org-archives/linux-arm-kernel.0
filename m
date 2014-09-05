From: broonie@kernel.org (Mark Brown)
Date: Fri, 5 Sep 2014 22:36:00 +0100
Subject: [PATCH v9 5/8] drivers: cpuidle: implement DT based idle states
 infrastructure
In-Reply-To: <20140905212908.GA28626@e102568-lin.cambridge.arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409938498-17984-6-git-send-email-lorenzo.pieralisi@arm.com>
 <7hlhpxygzv.fsf@paris.lan>
 <20140905212908.GA28626@e102568-lin.cambridge.arm.com>
Message-ID: <20140905213600.GJ29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 10:29:08PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Sep 05, 2014 at 09:00:52PM +0100, Kevin Hilman wrote:

> (3) Add an optional property to the DT bindings to describe the state

> (3) I am not extremely keen at this stage to re-patch the DT bindings,
> it has been an awful lot of work to make everyone agree so I would avoid
> any changes, I hope you understand (and I am not even sure DT maintainers
> would accept that, so even less keen on changing the DT bindings at this
> stage).

Just do it as an incremental patch if you're worried - we've got
precendents for this like regulator-name which exists solely to make
diagnostics more descriptive.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140905/94263623/attachment.sig>
