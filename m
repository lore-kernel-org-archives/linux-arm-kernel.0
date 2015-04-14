From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 14 Apr 2015 09:06:50 +0200
Subject: [GIT PULL v2 1/2] ARM: tegra: Core code changes for v4.1-rc1
In-Reply-To: <201504140109.56537.arnd@arndb.de>
References: <1427710333-13472-1-git-send-email-thierry.reding@gmail.com>
 <1428675733-23523-1-git-send-email-thierry.reding@gmail.com>
 <20150411015201.19585.59549@quantum>
 <201504140109.56537.arnd@arndb.de>
Message-ID: <20150414070649.GA11715@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 01:09:56AM +0200, Arnd Bergmann wrote:
> On Saturday 11 April 2015, Michael Turquette wrote:
> > > Tomeu Vizoso (8):
> > >       of: Document long-ram-code property in nvidia,tegra20-apbmisc
> > >       of: Document timings subnode of nvidia,tegra-mc
> > >       memory: tegra: Disable ARBITRATION_EMEM interrupt
> > >       of: document new emc-timings subnode in nvidia,tegra124-car
> > >       of: document external-memory-controller property in tegra124-car
> > >       clk: Expose clk_hw_reparent() to providers
> > 
> > ... this patch! I'd prefer to not do this. Let's see if
> > .set_rate_and_parent solve the problem for you.
> 
> Not pulling this for 4.1 then. Even without the objections, it was basically
> too late for the amount of changes now.

For my education, when do you expect pull requests with "this amount of
changes" to be sent?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150414/b456dac0/attachment-0001.sig>
