From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Mar 2016 18:19:00 +0000
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
In-Reply-To: <20160321180605.GE30977@lukather>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather> <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
 <20160314104939.GL8418@lukather>
 <20160319175124.6bfe3617@scratchpost.org>
 <20160321180605.GE30977@lukather>
Message-ID: <20160321181900.GZ2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 07:06:05PM +0100, Maxime Ripard wrote:

> I don't think you should focus too much on alsamixer, there's other
> tools to modify the configuration.

The expectation is that most users will use something like UCM and only
system integrators will see the full control set in normal operation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/7473e936/attachment-0001.sig>
