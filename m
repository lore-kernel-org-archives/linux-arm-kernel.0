From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 5 Jun 2017 08:59:07 +0100
Subject: [PATCH v3 3/9] mfd: tmio.h: support partition parser types
In-Reply-To: <CAAQYJAs_EMHUUBObbhOQ6gk4rh=MsO4d2qi9KpDdhMiHMrsyTA@mail.gmail.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-4-git-send-email-andrea.adami@gmail.com>
 <20170601143535.s6ovk5ts3cbehw3f@dell>
 <CAAQYJAs_EMHUUBObbhOQ6gk4rh=MsO4d2qi9KpDdhMiHMrsyTA@mail.gmail.com>
Message-ID: <20170605075906.2rdf74lzemys77to@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 03 Jun 2017, Andrea Adami wrote:

> On Thu, Jun 1, 2017 at 4:35 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 01 Jun 2017, Andrea Adami wrote:
> >
> >> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> >> ---
> >>  include/linux/mfd/tmio.h | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> >> index a1520d8..23bb069 100644
> >> --- a/include/linux/mfd/tmio.h
> >> +++ b/include/linux/mfd/tmio.h
> >> @@ -139,6 +139,7 @@ struct tmio_nand_data {
> >>       struct nand_bbt_descr   *badblock_pattern;
> >>       struct mtd_partition    *partition;
> >>       unsigned int            num_partitions;
> >> +     const char *const       *types; /* names of parsers to use if any */
> >
> > Please use kerneldoc instead.
> >
> Thanks for the review.
> 
> tmio.h is not consistent and uses inline comments so I did not change the style.
> Another round of patches will be necessary to sanitize the comments,
> out of the scope of this little patchset.

Will you do the work?

> >>  };
> >>
> >>  #define FBIO_TMIO_ACC_WRITE  0x7C639300
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
