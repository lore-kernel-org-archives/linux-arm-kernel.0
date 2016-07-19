From: alex.williamson@redhat.com (Alex Williamson)
Date: Tue, 19 Jul 2016 09:28:19 -0600
Subject: [PATCH V10 4/9] vfio: platform: add support for ACPI probe
In-Reply-To: <73439c6b-c9fc-6a5d-c90c-6b8d5cd5f3f5@codeaurora.org>
References: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
 <1468883367-2854-5-git-send-email-okaya@codeaurora.org>
 <20160718180049.78db3dfb@t450s.home>
 <b4655a0ba9152e6b2951e379e1615dad@codeaurora.org>
 <20160718182448.7b11a7af@t450s.home>
 <73439c6b-c9fc-6a5d-c90c-6b8d5cd5f3f5@codeaurora.org>
Message-ID: <20160719092819.0334c607@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jul 2016 10:49:54 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> On 7/18/2016 8:24 PM, Alex Williamson wrote:
> >>> nit, might make sense to replace EPERM with ENOENT and use EINVAL here.  
> >>> > >     
> >> > 
> >> > Sure, will take carr of it.
> >> > 
> >> > Anything else I need to take care of?  
> > Not that I see, maybe just send a new version of this patch if the
> > changes don't trickle through too much.  Thanks,  
> 
> I posted V11 with the discussed change. 
> 
> [PATCH V11 0/9] vfio, platform: add ACPI support
> 
> Do you see this making to 4.8 kernel?


I hope so, I'll try to get it into my next branch within the next day
or so.  Thanks,

Alex
