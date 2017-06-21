From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 21 Jun 2017 08:35:25 +0200
Subject: [PATCH v3] drm/exynos/dsi: Remove error handling for bridge_node
 DT parsing
In-Reply-To: <1498026812-18539-1-git-send-email-hoegeun.kwon@samsung.com>
References: <CGME20170621063347epcas1p46d2ccf5edbedc5386222c0fce3b2523a@epcas1p4.samsung.com>
 <1498026812-18539-1-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <CAJKOXPecr9RvAKb6EvfZRmf8UPenRLAqF6_B6DzamNEVbmCmpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 8:33 AM, Hoegeun Kwon <hoegeun.kwon@samsung.com> wrote:
> Remove the error handling of bridge_node because the bridge_node is
> optionally.

"is optional"

>
> For example, In case of Exynos SoC, a bridge device such as mDNIe and
> MIC could be placed between Display Controller and MIPI DSI device but
> the bridge device is optionally.

Ditto.

BR,
Krzysztof
