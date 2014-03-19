From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Mar 2014 17:03:18 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140319165058.GA21513@red-moon>
References: <1394009975-28655-1-git-send-email-broonie@kernel.org>
 <20140319160414.GA19953@red-moon>
 <20140319163339.GP11706@sirena.org.uk>
 <20140319165058.GA21513@red-moon>
Message-ID: <20140319170318.GS11706@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 04:50:58PM +0000, Lorenzo Pieralisi wrote:

> if (parse_dt_topology())
> 	reset_cpu_topology();

> If you want to leave ret there I do not care, I flag what I notice.

Oh, right.  I was confused because you said it was unused when it
clearly had a use.  I find that ugly since it looks like the test is the
wrong way around but whatever...

> parse_cluster() return value issue I flagged up must be fixed though.

Already done along with the other stylistic stuff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140319/466cb53b/attachment.sig>
