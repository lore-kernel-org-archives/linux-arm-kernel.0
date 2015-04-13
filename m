From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 01:09:56 +0200
Subject: [GIT PULL v2 1/2] ARM: tegra: Core code changes for v4.1-rc1
In-Reply-To: <20150411015201.19585.59549@quantum>
References: <1427710333-13472-1-git-send-email-thierry.reding@gmail.com>
 <1428675733-23523-1-git-send-email-thierry.reding@gmail.com>
 <20150411015201.19585.59549@quantum>
Message-ID: <201504140109.56537.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 11 April 2015, Michael Turquette wrote:
> > Tomeu Vizoso (8):
> >       of: Document long-ram-code property in nvidia,tegra20-apbmisc
> >       of: Document timings subnode of nvidia,tegra-mc
> >       memory: tegra: Disable ARBITRATION_EMEM interrupt
> >       of: document new emc-timings subnode in nvidia,tegra124-car
> >       of: document external-memory-controller property in tegra124-car
> >       clk: Expose clk_hw_reparent() to providers
> 
> ... this patch! I'd prefer to not do this. Let's see if
> .set_rate_and_parent solve the problem for you.

Not pulling this for 4.1 then. Even without the objections, it was basically
too late for the amount of changes now.

	Arnd
