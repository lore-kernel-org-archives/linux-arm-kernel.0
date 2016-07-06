From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 6 Jul 2016 11:02:46 -0600
Subject: [PATCH V2 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <20160705090431.5852-2-josephl@nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-2-josephl@nvidia.com>
Message-ID: <577D39B6.701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2016 03:04 AM, Joseph Lo wrote:
> Add DT binding for the Hardware Synchronization Primitives (HSP). The
> HSP is designed for the processors to share resources and communicate
> together. It provides a set of hardware synchronization primitives for
> interprocessor communication. So the interprocessor communication (IPC)
> protocols can use hardware synchronization primitive, when operating
> between two processors not in an SMP relationship.

Acked-by: Stephen Warren <swarren@nvidia.com>
