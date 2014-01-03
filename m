From: gnurou@gmail.com (Alexandre Courbot)
Date: Fri, 3 Jan 2014 20:19:12 +0900
Subject: [PATCH v2 4/6] ARM: tegra: rework fuse.c
In-Reply-To: <1387891931-9854-5-git-send-email-pdeschrijver@nvidia.com>
References: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
 <1387891931-9854-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAAVeFuJ2i6N-=bGqjTZNmgD3iT-7vSxaWze+QFLbf4jjhU7dNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 10:32 PM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> Reduce fuse.c to the minimum functionality required for the early bootstages.
> Also export tegra_read_straps() for use by the fuse driver.
>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Fine with this since the fuse clock is still explicitly enabled during init.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
