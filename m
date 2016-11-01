From: davem@davemloft.net (David Miller)
Date: Tue, 01 Nov 2016 12:05:44 -0400 (EDT)
Subject: [PATCH net-next 0/2] drivers: net: xgene: Fix coalescing bugs
In-Reply-To: <1477954827-9951-1-git-send-email-isubramanian@apm.com>
References: <1477954827-9951-1-git-send-email-isubramanian@apm.com>
Message-ID: <20161101.120544.1150664206040874267.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon, 31 Oct 2016 16:00:25 -0700

> This patch set fixes the following,
> 
>      1. Since ethernet v1 hardware has a bug related to coalescing,
> 	disabling this feature
>      2. Fixing ethernet v2 hardware, interrupt trigger region
> 	id to 2, to kickoff coalescing
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>

Series applied, thanks.
