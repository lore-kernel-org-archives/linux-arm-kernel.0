From: davem@davemloft.net (David Miller)
Date: Sat, 31 Mar 2018 22:07:30 -0400 (EDT)
Subject: [PATCH v2 0/7] net: thunderx: implement DMAC filtering support
In-Reply-To: <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180331.220730.1991017148197107974.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Fri, 30 Mar 2018 04:59:46 -0700

> From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> By default CN88XX BGX accepts all incoming multicast and broadcast
> packets and filtering is disabled. The nic driver doesn't provide
> an ability to change such behaviour.
> 
> This series is to implement DMAC filtering management for CN88XX
> nic driver allowing user to enable/disable filtering and configure
> specific MAC addresses to filter traffic.
> 
> Changes from v1:
> build issues:
>  - update code in order to address compiler warnings;
> checkpatch.pl reported issues:
>  - update code in order to fit 80 symbols length;
>  - update commit descriptions in order to fit 80 symbols length;

Series applied.
