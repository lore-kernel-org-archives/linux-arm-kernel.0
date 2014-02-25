From: greg@kroah.com (Greg KH)
Date: Tue, 25 Feb 2014 08:49:21 -0800
Subject: linux-next: manual merge of the staging tree with the arm-soc tree
In-Reply-To: <20140225170944.d322d9868871bc2f669b92e5@canb.auug.org.au>
References: <20140225170944.d322d9868871bc2f669b92e5@canb.auug.org.au>
Message-ID: <20140225164921.GA4458@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 05:09:44PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the staging tree got a conflict in
> arch/arm/boot/dts/imx53-qsb.dts between commit d5eb195f26fa ("ARM: dts:
> i.MX53: move common QSB nodes to new file") from the arm-soc tree and
> commit 17b5001b5143 ("imx-drm: convert to componentised device support")
> from the staging tree.
> 
> I fixed it up (see at bottom) and can carry the fix as necessary (no
> action is required).  I also added the following fix up patch:

I think it's right, but I really have no idea about any of these.  I'll
defer to Russell to ensure they are correct.

thanks,

greg k-h
