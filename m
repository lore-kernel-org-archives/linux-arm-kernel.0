From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 20 Aug 2015 11:11:23 +0100
Subject: [Xen-devel] [PATCH v3 00/20] xen/arm64: Add support for 64KB page
In-Reply-To: <55D521F2.5080504@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <55D521F2.5080504@citrix.com>
Message-ID: <55D5A7CB.3070207@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/15 01:40, Julien Grall wrote:
> Hi,
> 
> Ping? I'm missing some reviews on block and netfront code.
> 
> We'd like to see this series going in Linux 4.3. Some distributions
> plans to use this version for aarch64 support. If we miss it, we won't
> have any Xen guests support, even it's minimal, for Linux using 64KB
> page granularity.

This is too late for Linux 4.3.

David
