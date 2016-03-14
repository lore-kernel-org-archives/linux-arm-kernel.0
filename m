From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Mon, 14 Mar 2016 17:35:13 +0000
Subject: Regression in next caused by 95026658c46e i2c: do not use
 internal..
In-Reply-To: <20160314160944.GG9329@atomide.com>
References: <20160314160944.GG9329@atomide.com>
Message-ID: <56E6F651.5070409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 March 2016 04:09 PM, Tony Lindgren wrote:
> Hi Sudip & Wolfram,
>
> Looks like commit 95026658c46e ("i2c: do not use internal data from
> driver core") in Linux next introduced a regression breaking booting
> on most ARM boards according to kernelci.org [0].
>
> Having something like this happen just as the merge window opens is
> not nice. You guys should already know.. The patches in next should
> be sitting there for a few weeks before the merge window so issues
> like this are found out early.

Yes, sorry about the mess.

regards
sudip
