From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 20 May 2014 01:36:56 +0200
Subject: [PATCH 3/3] cpufreq: Enable big.LITTLE cpufreq driver on arm64
In-Reply-To: <20140519230729.GD30457@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <2437793.vfcRUkFCet@vostro.rjw.lan> <20140519230729.GD30457@sirena.org.uk>
Message-ID: <3610030.uyJEv7eFhP@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 20, 2014 12:07:29 AM Mark Brown wrote:
> 
> --MAH+hnPXVZWQ5cD/
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Tue, May 20, 2014 at 01:19:03AM +0200, Rafael J. Wysocki wrote:
> 
> > I've queued this one up for 3.16, thanks!
> 
> This will fail to build without patch 1 - it uses the stubs added there.

OK, dropping then.

Rafael
