From: dja@axtens.net (Daniel Axtens)
Date: Wed, 18 Oct 2017 11:24:43 +1100
Subject: [PATCH v2 2/2] vgaarb: Factor out EFI and fallback default device
 selection
In-Reply-To: <20171017120506.ervbnyjue55zn67b@phenom.ffwll.local>
References: <20171013034338.14630.4766.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171013034729.14630.30419.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <871sm2y1h9.fsf@linkitivity.dja.id.au>
 <20171017120506.ervbnyjue55zn67b@phenom.ffwll.local>
Message-ID: <878tg9i9pw.fsf@linkitivity.dja.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

>> Initially I wondered if this info printk could be moved into
>> vga_arbiter_check_bridge_sharing(), but it's been separated out since
>> 3448a19da479b ("vgaarb: use bridges to control VGA routing where
>> possible."), and upon closer examination, it seems you can't be sure a
>> device doesn't share a bridge until the end of the process, so this is
>> indeed correct.
>> 
>> Everything else also looks good to me.
>> 
>> Reviewed-by: Daniel Axtens <dja@axtens.net>
>
> R-b for both patches? And ok with everyone if I pull this into drm-misc
> for 4.15 (deadline is end of this week for feature-y stuff)?

I had only intended it for patch 2, but I've now read over patch 1 to my
satisfaction, so it too is:

Reviewed-by: Daniel Axtens <dja@axtens.net>

Thanks!

Regards,
Daniel

>
> Thanks, Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
