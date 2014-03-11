From: mporter@linaro.org (Matt Porter)
Date: Tue, 11 Mar 2014 11:49:30 -0400
Subject: [PATCH v2 1/5] mfd: add bcm590xx pmu DT binding
In-Reply-To: <20140219044726.GC2669@sirena.org.uk>
References: <1392765432-9111-1-git-send-email-mporter@linaro.org>
 <1392765432-9111-2-git-send-email-mporter@linaro.org>
 <20140219044726.GC2669@sirena.org.uk>
Message-ID: <20140311154930.GJ25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:47:26PM +0900, Mark Brown wrote:
> On Tue, Feb 18, 2014 at 06:17:08PM -0500, Matt Porter wrote:
> 
> > +
> > +				rfldo_reg: regulator at 0 {
> > +					reg = <0>;
> 
> What do these reg values mean, they don't seem to be documented in the
> binding?

Dropped this and the deprecated regulator-compatible property in v3 in
favor of using node name matching.

-Matt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/28baf18b/attachment.sig>
