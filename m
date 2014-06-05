From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 05 Jun 2014 14:10:04 +0200
Subject: [PATCH 3/3] cpufreq: Enable big.LITTLE cpufreq driver on arm64
In-Reply-To: <20140605100416.GB27946@arm.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <3610030.uyJEv7eFhP@vostro.rjw.lan> <20140605100416.GB27946@arm.com>
Message-ID: <20323352.3KEVHO00Qv@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 05, 2014 11:04:16 AM Catalin Marinas wrote:
> Hi Rafael,
> 
> On Tue, May 20, 2014 at 12:36:56AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, May 20, 2014 12:07:29 AM Mark Brown wrote:
> > > 
> > > --MAH+hnPXVZWQ5cD/
> > > Content-Type: text/plain; charset=us-ascii
> > > Content-Disposition: inline
> > > 
> > > On Tue, May 20, 2014 at 01:19:03AM +0200, Rafael J. Wysocki wrote:
> > > 
> > > > I've queued this one up for 3.16, thanks!
> > > 
> > > This will fail to build without patch 1 - it uses the stubs added there.
> > 
> > OK, dropping then.
> 
> This patch still made it as commit 4920ab84979d (cpufreq: Enable
> big.LITTLE cpufreq driver on arm64) and fails to build on arm64. Could
> you please revert it?

I will.

Rafael
