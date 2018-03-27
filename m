From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 27 Mar 2018 11:21:19 +0200
Subject: [PATCH 02/10] drm/sun4i: Disable YUV channel when using the
 frontend and set interlace
In-Reply-To: <20180327091823.sbmvvo4jsh3x7p4i@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-3-paul.kocialkowski@bootlin.com>
 <20180323095529.5nptn5achjt3esog@flea>
 <1522137643.1110.4.camel@bootlin.com>
 <20180327081731.he3lhnvqffuimsi5@flea>
 <1522140259.1110.43.camel@bootlin.com>
 <20180327091823.sbmvvo4jsh3x7p4i@flea>
Message-ID: <1522142479.1110.45.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-03-27 at 11:18 +0200, Maxime Ripard wrote:
> On Tue, Mar 27, 2018 at 10:44:19AM +0200, Paul Kocialkowski wrote:
> > > > Also, is interlacing actually used on any of the video outputs
> > > > we
> > > > support? Perhaps RGB?
> > > 
> > > Composite would be a better guess :)
> > 
> > Oh and I was wondering what CVBS was about. Now I know!
> > It seems that we don't support it for now apparently, anyway.
> 
> What do you mean? We do support it.

Sorry, I think I was remembering the status for A10/A20 only. Glad to
see that it works on A13!

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180327/16749523/attachment.sig>
