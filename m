From: davem@davemloft.net (David Miller)
Date: Wed, 04 Mar 2015 15:54:38 -0500 (EST)
Subject: [PATCH v2 0/3] drivers: net: xgene: Fix backward compatibility
 of newer firmware with older kernel
In-Reply-To: <1425411581-25463-1-git-send-email-isubramanian@apm.com>
References: <1425411581-25463-1-git-send-email-isubramanian@apm.com>
Message-ID: <20150304.155438.1283662648499374073.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Tue,  3 Mar 2015 11:39:38 -0800

> Kernel 3.17 driver supports only RGMII ethernet interface.
> Since the Tianocore DT contains same compatibility string for RGMII,
> SGMII based 1G and XFI based 10G interfaces, crash happens when probe called
> on SGMII based 1G and XFI based 10G interface.
> 
> This patch fixes the backward compatibility of the older driver with the
> newer firmware by making the binding unique so that the older driver won't
> recognize the non-supported interfaces.
> 
> v2: Address comments from v1
> * updated cover letter subject line with net: xgene
> * Documentation: formatted compatible string values as list
> 
> v1:
> * Initial version

Series applied, thanks.
