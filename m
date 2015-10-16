From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Oct 2015 12:11:12 -0700
Subject: [PATCH v2 3/3] ARM: OMAP2: AM43XX: Modify optimize string
 comparisons in soc_is calls
In-Reply-To: <1444885808-6306-4-git-send-email-j-keerthy@ti.com>
References: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
 <1444885808-6306-4-git-send-email-j-keerthy@ti.com>
Message-ID: <20151016191111.GC24370@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [151014 22:14]:
> Currently everytime soc_is calls are made, firstly device tree nodes
> are parsed and then string comparisons are made to determine the
> soc version. Optimizing it to be done one time and store the result.
> Use the stored value in all the subsequent checks for soc_is calls.

Here too we should rely on the hawkeye register or similar.

Regards,

Tony
