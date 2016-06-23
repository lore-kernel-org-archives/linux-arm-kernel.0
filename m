From: horms@verge.net.au (Simon Horman)
Date: Thu, 23 Jun 2016 09:41:35 +0900
Subject: [PATCH 0/2] Simple fix to the ARM kexec tools implementation
In-Reply-To: <20160621082033.GS1041@n2100.armlinux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <20160621061128.GC29309@dhcppc9>
 <20160621082033.GS1041@n2100.armlinux.org.uk>
Message-ID: <20160623004135.GB9412@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 09:20:33AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 21, 2016 at 11:41:28AM +0530, Pratyush Anand wrote:
> > Yes, so until we have proper header for zImage, these patches looks
> > fine to me.
> 
> If you read my last email in the "kexec failures with DEBUG_RODATA"
> thread, you'll see that I'm unhappy with this idea, because adding a
> "proper header" still results in some kind of assumption about how
> the zImage decompressor works being needed by the boot environment.
> 
> > For both of the patches:
> > 
> > Reviewed-by: Pratyush Anand <panand@redhat.com>
> 
> Thanks.
> 
> Simon, do you need me to resend with the r-b tag, or will you pick
> these two up and the documentation fix patch you asked for?

Thanks for reminding me about this, I have applied this patch
and the other one you mention.
