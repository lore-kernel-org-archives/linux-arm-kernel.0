From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 17 Apr 2010 10:54:29 +0900
Subject: [alsa-devel] [PATCH 1/4] pxa: add namespace on ssp
In-Reply-To: <m2p771cded01004152054yc1e0d362z16b8f931339e6f36@mail.gmail.com>
References: <k2s771cded01003310546y48e1431r71820b73f69e53d5@mail.gmail.com>
	<20100409111609.GA13281@sirena.org.uk>
	<m2p771cded01004152054yc1e0d362z16b8f931339e6f36@mail.gmail.com>
Message-ID: <20100417015428.GA25725@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 15, 2010 at 11:54:08PM -0400, Haojian Zhuang wrote:

> Excuse me for late response. Now patches are refreshed and they're
> still based on Eric's ssp-cleanup branch. Since these patches are
> relied on some ssp's fix. Do you want to immigrate these patches into
> ASoC's tree? Would you pull eric's ssp-cleanup branch into ASoC tree?

Pulling the SSP cleanup branch into both ASoC and PXA (or just ASoC) has
been what I've been suggesting, but I'm not sure if Eric is comfortable
with that idea?

Please post patch serieses individually, not as one big set of
attachments - it's much easier to apply using standard tools like git am.
