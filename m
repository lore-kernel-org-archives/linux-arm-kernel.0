From: geoff@infradead.org (Geoff Levand)
Date: Tue, 14 Jun 2016 14:56:38 -0700
Subject: [PATCH v18 08/13] arm64: kdump: implement machine_crash_shutdown()
In-Reply-To: <20160614071348.GN20774@linaro.org>
References: <cover.1465502767.git.geoff@infradead.org>
 <9bc011f03f5dd30fc66178461d303d3ec1b7ac35.1465502767.git.geoff@infradead.org>
 <20160614071348.GN20774@linaro.org>
Message-ID: <1465941398.21058.1.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-06-14 at 16:13 +0900, AKASHI Takahiro wrote:
> On Thu, Jun 09, 2016 at 08:08:44PM +0000, Geoff Levand wrote:
> >  
> > -> > 	> > cpu_soft_restart(1, reboot_code_buffer_phys, kimage->head,
> > +> > 	> > cpu_soft_restart(in_crash_kexec, reboot_code_buffer_phys, kimage->head,
> 
>                         => !in_crash_kexec
> 
> Please let me recognize any changes you made clearly if you modified my part
> in the patchset before posting it.

I pushed out a new branch kexec-v18.1 with this fix.  Thanks for
checking!

-Geoff
