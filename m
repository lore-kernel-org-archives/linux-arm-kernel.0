From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Sep 2013 11:20:27 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <523186DF.4070203@freescale.com>
References: <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk>
 <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk>
 <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk>
 <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk>
 <523186DF.4070203@freescale.com>
Message-ID: <20130912102027.GF29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 05:18:23PM +0800, Huang Shijie wrote:

> yes. The driver uses the commands to find the _right_ LUT index, and
> uses the LUT index to
> trigger the controller.

What is a LUT index?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/ef6c7710/attachment.sig>
