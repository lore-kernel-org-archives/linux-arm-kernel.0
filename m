From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 30 Jun 2012 12:45:17 +0100
Subject: [PATCH 3/3] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <4FEDE6AE.4080409@wwwdotorg.org>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <1340406842-27135-3-git-send-email-swarren@wwwdotorg.org>
 <1963397.cqAXgGafFs@ax5200p> <20120624110306.GA16455@sirena.org.uk>
 <4FEA3942.9040906@wwwdotorg.org>
 <20120626230235.GX30406@opensource.wolfsonmicro.com>
 <4FEDE6AE.4080409@wwwdotorg.org>
Message-ID: <20120630114517.GV28922@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 11:32:30AM -0600, Stephen Warren wrote:

> Just FYI, the particular choice of "/" as a separator doesn't work
> well, because then /sys/kernel/debug/regulator/${regulator-name} can't
> be created. I guess I'll use a comma. I assume it's not worth fixing
> the regulator core to s@/@,@ when generating the debugfs filenames?

I don't think that's sensible, no.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120630/9ea5b02b/attachment.sig>
