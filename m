From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 12 Aug 2011 09:07:27 -0700
Subject: [PATCH v2 1/4] gpio/tegra: Remove use of irq_to_gpio
In-Reply-To: <CAMbhsRRGDAmYv3_EbJ+WVg0C7e3-FFcLCgq4W325ECKX06M6Hg@mail.gmail.com>
References: <1313095404-27858-1-git-send-email-swarren@nvidia.com>
	<CAMbhsRRGDAmYv3_EbJ+WVg0C7e3-FFcLCgq4W325ECKX06M6Hg@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA24E3D@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross wrote at Thursday, August 11, 2011 2:54 PM:
> On Thu, Aug 11, 2011 at 1:43 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > irq_to_gpio is being removed. Replace the only use of that API by
> > the ARM Tegra sub-architecture.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > This series is the irq_to_gpio patches I posted last week, rebased to ToT,
> > plus removing Tegra's custom gpio_to_irq.
> >
> > This series was tested against next-20110811 on Harmony, by playing audio
> > and plugging/unplugging headphones. Headphone detection relies on using a
> > GPIO as an IRQ, and hence on gpio_to_irq.
> 
> This whole series looks good to me:
> Acked-by: Colin Cross <ccross@android.com>

Grant, Does this series look OK to you? Russell asked me to add it to the
ARM patch system once you'd Ack'd it.

Thanks.

-- 
nvpublic
