From: davem@davemloft.net (David Miller)
Date: Tue, 02 May 2017 15:47:44 -0400 (EDT)
Subject: [PATCH 0/9] net: thunderx: Adds XDP support
In-Reply-To: <1493730418-24606-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1493730418-24606-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20170502.154744.1762061314370744901.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Tue,  2 May 2017 18:36:49 +0530

> From: Sunil Goutham <sgoutham@cavium.com>
> 
> This patch series adds support for XDP to ThunderX NIC driver
> which is used on CN88xx, CN81xx and CN83xx platforms. 
> 
> Patches 1-4 are performance improvement and cleanup patches
> which are done keeping XDP performance bottlenecks in view.
> Rest of the patches adds actual XDP support.

Series applied, thanks for doing this work.

Do you have any performance numbers?
