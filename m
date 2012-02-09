From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 09 Feb 2012 12:24:35 +0200
Subject: [PATCH 00/16] rmk's patch series for fixing OMAP
In-Reply-To: <1328776220.12747.5.camel@lws-gamez>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <4F32DBB5.4010004@gmx.de>  <20120209005334.GG25414@n2100.arm.linux.org.uk>
 <1328770969.1909.11.camel@deskari>  <1328776220.12747.5.camel@lws-gamez>
Message-ID: <1328783075.1909.44.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-02-09 at 09:30 +0100, Teresa Gamez wrote:
> Am Donnerstag, den 09.02.2012, 09:02 +0200 schrieb Tomi Valkeinen:

> > The problem is present in all kernels where we have the HDMI driver, so
> > 2.6.39+.
> 
> Are there already backported patches out there for 3.0/3.1?
> We are quite interested in this.

I pushed three branches to git://gitorious.org/linux-omap-dss2/linux.git

fixes/for-3.0-stable
fixes/for-3.1-stable
fixes/for-3.2-stable

Which contain the necessary backported patches for each version.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120209/d63a7694/attachment.sig>
