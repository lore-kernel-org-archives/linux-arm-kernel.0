From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 22 Sep 2009 21:43:23 +0100
Subject: What is the status on s3c2442b support?
In-Reply-To: <fbec40cf0909180737r48687a45o4b6ba4dc68ed4fa6@mail.gmail.com>
References: <fbec40cf0909180737r48687a45o4b6ba4dc68ed4fa6@mail.gmail.com>
Message-ID: <20090922204323.GC31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2009 at 04:37:39PM +0200, Sveinung Kvilhaugsvik wrote:
> Hi
> 
> What is the status on the patch in
> http://marc.info/?t=124198900000003&r=1&w=2 (Introduce s3c2442b CPU)?
> As far as I understand from [1] this patch is all that is needed to
> make Linux boot on the Openmoko Neo Freerunner. Is it stuck here or
> someplace else? Are there a technical reason to not merge it? Is there
> a chance to get it into 2.6.32? Anything I can do to help it get in?
> 
> [1] http://kerneltrap.org/mailarchive/openmoko-kernel/2009/7/29/6268823/thread#mid-6268823
> 
> Sincerely
> Sveinung Kvilhaugsvik

I've merged this into next-s3c24xx-fixes and will send a pull request
once a couple of other issues have been dealt with.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
