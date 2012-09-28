From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 28 Sep 2012 08:51:23 +0200
Subject: [PATCH V2 3/3] ARM: EXYNOS: Add drm-device node to the dtsi file
In-Reply-To: <135e01cd9b88$aea81140$0bf833c0$@org>
References: <1348232397-2477-1-git-send-email-l.krishna@samsung.com>
 <1348232397-2477-4-git-send-email-l.krishna@samsung.com>
 <135e01cd9b88$aea81140$0bf833c0$@org>
Message-ID: <2322047.YHar8WY1rI@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 26 of September 2012 10:46:01 Kukjin Kim wrote:
> Please check below comments from Thomas Abraham and I agree with his
> opinion.
> 
> There cannot be a node that represents a virtual device. Device tree
> should ideally describe the hardware but the above node does not
> represent a hardware device. The creation of the platform device
> instance for the above device should handled inside the kernel code.

I don't tend to agree with this opinion. Is there any further reasoning 
behind it? Is it a current policy of the kernel that nodes should only 
represent real devices?

Best regards,
Tomasz Figa
