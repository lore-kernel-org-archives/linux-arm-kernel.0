From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Sep 2018 12:12:53 +0100
Subject: [PATCH] arm64: Remove unused VGA console support
In-Reply-To: <1536839800-14918-1-git-send-email-andrew.murray@arm.com>
References: <1536839800-14918-1-git-send-email-andrew.murray@arm.com>
Message-ID: <20180921111252.GA238853@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 12:56:40PM +0100, Andrew Murray wrote:
> Support for VGA_CONSOLE is not allowable due to commit ee23794b8668
> ("video: vgacon: Don't build on arm64"), thus remove the associated
> unused code.
> 
> Whilst PCI on arm64 would support VGA a valid screen_info structure
> is missing.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Queued for 4.20. Thanks.

-- 
Catalin
