From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 29 Aug 2013 20:58:55 +0800
Subject: [PATCH RFC v2 08/16] ARM: mxs: remove custom .init_time hook
In-Reply-To: <521F3151.1030704@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-9-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130829110849.GB18729@S2101-09.ap.freescale.net>
 <521F3151.1030704@gmail.com>
Message-ID: <20130829125851.GK18729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 01:32:33PM +0200, Sebastian Hesselbarth wrote:
> Ok, will take care of it. I assume you are fine with having an extra
> struct device_node pointer for the sake of readability instead of
> reusing the same pointer.

Yeah, something like np_digctl for digctl node.

Thanks for your work.

Shawn
