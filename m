From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Mar 2016 11:09:03 +0900
Subject: [PATCH v2 0/2] ARM: dts: r8a7793: add CAN to device tree
In-Reply-To: <1458093176-1926-1-git-send-email-horms+renesas@verge.net.au>
References: <1458093176-1926-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160317020903.GA25402@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 10:52:54AM +0900, Simon Horman wrote:
> Hi,
> 
> this short series adds CAN clocks and nodes to the r8a7793 device tree.
> 
> I am not aware of an r8a7793 board that exposes CAN - the gose
> board does not appear to - and thus am unsure of a way to test these changes.
> However, they are based on what is present for the r8a7791 SoC and
> I am unable to find a difference in the SoC documentation.
> 
> This series is similar to a series I posted for the r8a7794
> earlier this week.
> 
> Based on renesas-devel-20160315-v4.5

I have queued this up for v4.7.
