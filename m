From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 9 May 2017 14:04:34 +0200
Subject: [PATCH 1/4] net: macb: Add support for PTP timestamps in DMA
 descriptors
In-Reply-To: <1494321885-14384-1-git-send-email-rafalo@cadence.com>
References: <1494321885-14384-1-git-send-email-rafalo@cadence.com>
Message-ID: <20170509120434.GA9368@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 10:24:45AM +0100, Rafal Ozieblo wrote:
> This patch adds support for PTP timestamps in
> DMA buffer descriptors. It checks capability at runtime
> and uses appropriate buffer descriptor.
> 
> Signed-off-by: Rafal Ozieblo <rafalo@cadence.com>

You posted this series once before, on April 13, 2017.  That makes
this v2.  Please add v2 in the subject line, eg. [PATCH v2 1/4].

Also, add a cover letter [0/4] that summarizes the changes between v1
and v2 of the series.

Thanks,
Richard
