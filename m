From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 23 Jan 2013 11:18:05 +0000
Subject: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into
 the driver
In-Reply-To: <20130123101748.GO23505@n2100.arm.linux.org.uk>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
 <20130122090000.GH6857@gmail.com>
 <CACRpkdatTagYaMqvpe-a8zj_kO3Twjn1r4SqPty8DosNmcxJcQ@mail.gmail.com>
 <20130122100607.GH23505@n2100.arm.linux.org.uk>
 <20130122102010.GL6857@gmail.com>
 <20130122103723.GI23505@n2100.arm.linux.org.uk>
 <20130122105608.GP6857@gmail.com>
 <20130123101349.GH15873@gmail.com>
 <20130123101748.GO23505@n2100.arm.linux.org.uk>
Message-ID: <20130123111805.GI15873@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Jan 2013, Russell King - ARM Linux wrote:

> On Wed, Jan 23, 2013 at 10:13:49AM +0000, Lee Jones wrote:
> > On Tue, 22 Jan 2013, Lee Jones wrote:
> > > Are you saying that you won't do it? :)
> > > 
> > > Is there anything I can do to make the process easier?
> > 
> > Thinking about this a little more. Is it easier to remove it from your
> > tree altogether? Only I have a small "ARM: ux500: " patch-set which
> > directly relies on this patch. I could take it in via ARM-SoC without
> > any fear of ordering issues.
> 
> Thankfully, the patch doesn't conflict with any of the others I have, so
> we can do that (and it's actually easier to do that.)
> 
> Done.

Brilliant, that's 2 birds with one stone. I'll queue it up for ARM-SoC.

Thanks Russell.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
