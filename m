From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 7 Jan 2016 21:02:14 -0800
Subject: ION DTS changes for HiKey in -next
In-Reply-To: <20160107173744.GJ6588@sirena.org.uk>
References: <20160107173744.GJ6588@sirena.org.uk>
Message-ID: <20160108050214.GD30293@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 05:37:44PM +0000, Mark Brown wrote:
> Hi Greg,
> 
> I was just looking at DTs in -next and noticed that there is a patch
> 59dfafd03fc (arm64: dts: Add dts files to enable ION on Hi6220 SoC)
> which adds at DT doing something for ION.  Are we sure this should be
> going into the main production DT?  The bindings haven't been reviewed
> as far as I can tell, the matching driver is only in staging and hasn't
> been posted upstream.

Isn't "staging" upstream enough for this?  :)

If not, let me know and I'll be glad to drop this patch, it was on the
list for a while with no objections.

thanks,

greg k-h
