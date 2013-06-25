From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 19:02:43 +0300
Subject: OMAP baseline test results for v3.10-rc6
In-Reply-To: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
Message-ID: <20130625160243.GE22312@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 17, 2013 at 05:23:17AM +0000, Paul Walmsley wrote:
> Boot to userspace:
>     FAIL ( 3/12): 37xxevm, am335xbone, am335xbonelt

Paul, we have at least 2 different folks who can't reproduce your bone
and bone black boot to userspace failures. I wonder how you're trying to
boot them.

Care to share your test scripts ?

Also, if you could share the entire thing, we will add your scripts to
our nightly tests as to try and avoid future regressions.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/f6887588/attachment.sig>
