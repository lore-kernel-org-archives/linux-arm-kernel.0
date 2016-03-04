From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 18:15:52 -0600
Subject: [PATCH v14 3/6] of, numa: Add NUMA of binding implementation.
In-Reply-To: <1457049339-23351-4-git-send-email-ddaney.cavm@gmail.com>
References: <1457049339-23351-1-git-send-email-ddaney.cavm@gmail.com>
 <1457049339-23351-4-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <CAL_JsqLf9ZmLYz4zrXP1LciKm1DhtB4ycEC79MXt2t8iDyiEuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 5:55 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> Add device tree parsing for NUMA topology using device
> "numa-node-id" property in distance-map and cpu nodes.
>
> This is a complete rewrite of a previous patch by:
>    Ganapatrao Kulkarni<gkulkarni@caviumnetworks.com>
>
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: Rob Herring <robh@kernel.org>
