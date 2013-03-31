From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 31 Mar 2013 02:35:03 +0000 (UTC)
Subject: [RFC][PATCH 0/5] Introduce .get_voltage callback into voltdm
In-Reply-To: <1349313365-5262-1-git-send-email-mturquette@ti.com>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Message-ID: <alpine.DEB.2.00.1303310234110.6436@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Kevin,

On Wed, 3 Oct 2012, Mike Turquette wrote:

> From: Mike Turquette <mturquette@linaro.org>
> 
> This series creates a new callback for struct voltagedomain,
> .get_voltage.  This fetches the voltage from hardware, if possible, and
> returns it to the caller.  We use this call to populate
> voltdm->nominal_volt at boot time.

Just checking on the status of this series.  Is this superseded by 
Andrii's driver?  Does it need to be reposted for merging?  etc.


- Paul
