From: davem@davemloft.net (David Miller)
Date: Wed, 14 Mar 2018 13:17:41 -0400 (EDT)
Subject: [PATCH 0/5] DPAA Ethernet fixes
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Message-ID: <20180314.131741.1258816057122849215.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Wed, 14 Mar 2018 08:37:27 -0500

> This patch set is addressing several issues in the DPAA Ethernet
> driver suite:
> 
>  - module unload crash caused by wrong reference to device being left
>    in the cleanup code after the DSA related changes
>  - scheduling wile atomic bug in QMan code revealed during dpaa_eth
>    module unload
>  - a couple of error counter fixes, a duplicated init in dpaa_eth.

Series applied, thank you.
