From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Jun 2017 17:56:33 -0500
Subject: [PATCH 1/9] Documentation: dt-bindings: add support for mailbox
 client shared memory
In-Reply-To: <1498492513-29771-2-git-send-email-sudeep.holla@arm.com>
References: <1498492513-29771-1-git-send-email-sudeep.holla@arm.com>
 <1498492513-29771-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20170628225633.rvfwc4s6rfqwo2jb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 04:55:05PM +0100, Sudeep Holla wrote:
> Many users of the mailbox controllers depend on the shared memory between the
> two end points to exchange the main data while using simple doorbell mechanism
> to alert the end points of the presence of a message.

"dt-bindings: mailbox: ..." for the subject.

> 
> This patch defines device tree bindings to represent such shared memory in a
> generic way.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  .../devicetree/bindings/mailbox/mailbox.txt        | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
