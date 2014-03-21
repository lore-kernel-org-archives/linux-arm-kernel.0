From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 21 Mar 2014 10:12:17 +0200
Subject: [PATCH 0/4] clk: dt: add support for default rate/parent
In-Reply-To: <20140320212308.21989.36094@quantum>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
 <53172239.3030705@ti.com> <20140320212308.21989.36094@quantum>
Message-ID: <20140321081217.GD26674@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 10:23:08PM +0100, Mike Turquette wrote:
> Quoting Tero Kristo (2014-03-05 05:10:17)
> > Ping.
> > 
> > Mike, any feedback on this?
> 
> Hi Tero,
> 
> Have you seen Sylwester's approach[1]? I prefer it since it is more
> device-oriented and less "centralized". The clock consumer enumerates
> the default parent or rate of a consumed clock. This can be made to work

That assumes driver writers are aware of the clock tree topology. IME that's
seldomly the case.

Cheers,

Peter.
