From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 12 Dec 2013 10:12:49 +0900
Subject: [PATCH 07/12] pcie: designware: add dw_pcie prefix before
 cfg_read/write
In-Reply-To: <CAD6G_RTiswApVUz_A3V8A++tQcWaWi2rRtVCuCAFE1eWY6d0CQ@mail.gmail.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <11157a3462fcad1067bddd27dcd580bbeb2c289e.1386752447.git.mohit.kumar@st.com>
 <CAD6G_RTiswApVUz_A3V8A++tQcWaWi2rRtVCuCAFE1eWY6d0CQ@mail.gmail.com>
Message-ID: <002301cef6d7$462451f0$d26cf5d0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 11, 2013 8:40 PM, Jagan Teki wrote:
> On Wed, Dec 11, 2013 at 3:08 PM, Mohit Kumar <mohit.kumar@st.com> wrote:
> > From: Pratyush Anand <pratyush.anand@st.com>
> >
> > cfg_read/write function are designware pcie specific. Add dw_pcie prefix
> > to avoid collision in global name space.
> >
> > Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> > Cc: Mohit Kumar <mohit.kumar@st.com>
> > Cc: Jingoo Han <jg1.han@samsung.com>
> > Cc: spear-devel at list.st.com
> > Cc: linux-pci at vger.kernel.org
> > ---
> >  drivers/pci/host/pci-exynos.c      |    5 +++--
> >  drivers/pci/host/pcie-designware.c |   23 ++++++++++++++---------
> >  drivers/pci/host/pcie-designware.h |    4 ++--

[....]

> Acked-by: Jagannadha Sutradharudu Teki <jagannadh.teki@gmail.com>

Please use ' Reviewed-by', instead of 'Acked-by'.
It will apply to other patches, too.

According to the ./Documentation/SubmittingPatches,

Acked-by: is often used by the maintainer of the affected code when that
maintainer neither contributed to nor forwarded the patch.

Reviewed-by:, instead, indicates that the patch has been reviewed and found
acceptable according to the Reviewer's Statement:

Best regards,
Jingoo Han
