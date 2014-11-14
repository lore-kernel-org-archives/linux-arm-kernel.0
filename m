From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 14 Nov 2014 10:14:48 +0100
Subject: [PATCH v7 01/12] clk: tegra: Implement memory-controller clock
In-Reply-To: <20141114015356.25314.26550@quantum>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
 <1415871157-21968-2-git-send-email-thierry.reding@gmail.com>
 <20141114015356.25314.26550@quantum>
Message-ID: <20141114091447.GA3810@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 05:53:56PM -0800, Mike Turquette wrote:
> Quoting Thierry Reding (2014-11-13 01:32:26)
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The memory controller clock runs either at half or the same frequency as
> > the EMC clock.
> > 
> > Reviewed-By: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Mike, as I said in the cover letter there are tight dependencies between the
> > patches in this series, so I'd like to get your Acked-by on this one so I can
> > take it through the Tegra tree along with the others.
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>

Thanks Mike,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/c5fd22f2/attachment-0001.sig>
