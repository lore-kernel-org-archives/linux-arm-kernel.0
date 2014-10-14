From: davem@davemloft.net (David Miller)
Date: Tue, 14 Oct 2014 16:10:01 -0400 (EDT)
Subject: [PATCH v2 0/4] Add SGMII based 1GbE support to APM X-Gene SoC
 ethernet driver
In-Reply-To: <1413245135-2989-1-git-send-email-isubramanian@apm.com>
References: <1413245135-2989-1-git-send-email-isubramanian@apm.com>
Message-ID: <20141014.161001.808204632101029906.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon, 13 Oct 2014 17:05:31 -0700

> Adding SGMII based 1GbE basic support to APM X-Gene SoC ethernet driver.
> 
> v2: Address comments from v1
> * Split the patchset into two, the first one being preparatory patch
> * Added link_state function pointer to the xgene_mac_ops structure
> * Added xgene_indirect_ctl structure for indirect read/write arguments
> 
> v1:
> * Initial version

Series applied, thanks.
