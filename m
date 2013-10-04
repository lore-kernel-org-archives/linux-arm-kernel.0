From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Oct 2013 21:52:52 +0100
Subject: [PATCH] clk: palmas: add clock driver for palmas
In-Reply-To: <20131004193545.4343.15596@quantum>
References: <1380803407-15196-1-git-send-email-ldewangan@nvidia.com>
 <20131004164139.GR27287@sirena.org.uk>
 <20131004193545.4343.15596@quantum>
Message-ID: <20131004205252.GU27287@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 12:35:45PM -0700, Mike Turquette wrote:

> The best solution is to have a driver claim the clock with clk_get and
> enable it with clk_prepare_enable. I gave more detail in my reply to
> Laxman.

Yeah, definitely - though with regulators we did find that there were
some passive things which didn't really warrant a driver for any purpose
other than holding the reference to them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131004/4bf8cf3d/attachment.sig>
