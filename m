From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 30 Jun 2014 14:30:13 +0300
Subject: [RFC 3/4] soc/tegra: Initialize interrupt controller from DT
In-Reply-To: <1403888329-24755-3-git-send-email-thierry.reding@gmail.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <1403888329-24755-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140630113013.GS3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 06:58:48PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Obtains the register ranges for the legacy interrupt controller from DT
> and provide hard-coded values as fallback.
> 

Any reason this file cannot be in drivers/irqchip/ ?

Cheers,

Peter.
