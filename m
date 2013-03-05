From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 5 Mar 2013 11:24:48 +0000
Subject: [PATCH v4 1/5] ARM: davinci: mmc: derive version information
 from device name
In-Reply-To: <512DF1F7.6010508@ti.com>
References: <1360909322-1858-1-git-send-email-prakash.pm@ti.com>
 <1360909322-1858-2-git-send-email-prakash.pm@ti.com>
 <512DF1F7.6010508@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA484F0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 17:15:59, Nori, Sekhar wrote:
> On 2/15/2013 11:51 AM, Manjunathappa, Prakash wrote:
> > Remove specifying mmc controller IP version information via platform
> > data, instead specify device name so that driver derives it from
> > platform_device_id table. Also change the clock node name to match
> > the changed dev_id.
> > Tested on da850-evm to make sure driver loads without clk_get failures.
> > 
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> 
> The patch looks good to me, but after this patch MMC/SD will be broken.
> I suggest merging this into 2/5. It makes little sense without those
> changes anyway.
> 

Ok I will merge this with 2/5.

Thanks,
Prakash 
