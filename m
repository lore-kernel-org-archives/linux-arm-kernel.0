From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 09 Aug 2017 15:47:34 -0700
Subject: [PATCH v4 05/12] Documentation: net: phy: Add phy-is-internal
 binding
In-Reply-To: <1502280630-2254-1-git-send-email-david.wu@rock-chips.com>
References: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
 <1502280630-2254-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <778B0470-8ABD-46AD-A63D-F0CF4911C800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On August 9, 2017 5:10:30 AM PDT, David Wu <david.wu@rock-chips.com> wrote:
>Add the documentation for internal phy. A boolean property
>indicates that a internal phy will be used.
>
>Signed-off-by: David Wu <david.wu@rock-chips.com>
>---
> Documentation/devicetree/bindings/net/phy.txt | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/Documentation/devicetree/bindings/net/phy.txt
>b/Documentation/devicetree/bindings/net/phy.txt
>index b558576..942c892 100644
>--- a/Documentation/devicetree/bindings/net/phy.txt
>+++ b/Documentation/devicetree/bindings/net/phy.txt
>@@ -52,6 +52,9 @@ Optional Properties:
>   Mark the corresponding energy efficient ethernet mode as broken and
>   request the ethernet to stop advertising it.
> 
>+- phy-is-internal: If set, indicates that phy will connect to the MAC
>as a
>+  internal phy.

Something along the lines of:

If set, indicates that the PHY is integrated into the same physical package as the Ethernet MAC.

Please always capitalize PHY.


-- 
Florian
