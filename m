From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 03 Mar 2017 09:26:07 +0900
Subject: [PATCH v3 2/7] arm: dts: Add the burst and esc clock frequency
 properties for exynos3250 dts
In-Reply-To: <1488450019-6482-3-git-send-email-hoegeun.kwon@samsung.com>
References: <1488450019-6482-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170302102113epcas1p343e9da20f05be0a2359bf32834626c4a@epcas1p3.samsung.com>
 <1488450019-6482-3-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170303002607.fdw6ipqzzvo6j5wh@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoegeun,

On Thu, Mar 02, 2017 at 07:20:14PM +0900, Hoegeun Kwon wrote:
> The OF graph is not needed because the panel is a child of dsi. So
> added the burst and esc clock frequency properties to the parent (DSI
> node), taking into account the bisectability problem so that remove
> the OF graph from DSI node.

nitpick:

1. bisectability is not a problem (and for bisectability you
   should not mention it in the commit log, you would confuse
   bisecting people)

2. you should use the imperative form, not "added the burst... "
   but "add the burst..."

Same for the other patches.

Andi
