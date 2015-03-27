From: davem@davemloft.net (David Miller)
Date: Fri, 27 Mar 2015 14:21:04 -0700 (PDT)
Subject: [PATCH net-next v1 0/3] drivers: net: xgene: Add separate tx
 completion ring
In-Reply-To: <1427311152-30333-1-git-send-email-isubramanian@apm.com>
References: <1427311152-30333-1-git-send-email-isubramanian@apm.com>
Message-ID: <20150327.142104.396378238473908305.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Wed, 25 Mar 2015 12:19:09 -0700

> SGMII based 1GbE and 10GbE interfaces support multiple interrupts.
> Adding separate tx completion descriptor ring and associating a dedicated irq for the TX completion.
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Signed-off-by: Keyur Chudgar <kchudgar@apm.com>

Series applied, thanks.
