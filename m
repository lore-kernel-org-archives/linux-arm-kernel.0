From: olof@lixom.net (Olof Johansson)
Date: Tue, 16 Apr 2013 09:36:00 -0700
Subject: [PATCH v6 3/3] ARM: dts: Add sbs-battery for exynos5250-snow
In-Reply-To: <1366129742-16048-3-git-send-email-dianders@chromium.org>
References: <1365543270-10736-1-git-send-email-dianders@chromium.org>
 <1366129742-16048-1-git-send-email-dianders@chromium.org>
 <1366129742-16048-3-git-send-email-dianders@chromium.org>
Message-ID: <20130416163600.GC4918@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 09:29:02AM -0700, Doug Anderson wrote:
> Now that we have i2c-arbitrator in place on bus 4 we can add the
> sbs-battery driver.  Future devices will be added onto bus 4 once
> drivers are in good shape.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
