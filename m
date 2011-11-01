From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Nov 2011 12:52:12 +0000
Subject: [PATCH v5 2/7] arm: pmu: allow platform specific irq
	enable/disable handling
In-Reply-To: <20111101112646.75fba9db@tom-ThinkPad-T410>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-3-git-send-email-ming.lei@canonical.com>
	<20111101112646.75fba9db@tom-ThinkPad-T410>
Message-ID: <20111101125212.GB15232@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2011 at 03:26:46AM +0000, Ming Lei wrote:
> Attach the patch [PATCH v5 2/7] which is rebased on 3.1 -next.

Great, thanks for that.

> BTW: The [PATCH v5 3/7] should be dropped as commented before, other patches
> are OK against 3.1 -next.

Ok, I'll pick up patches 1 and 2. The OMAP guys can take the rest as and
when they're happy with them.

Will
