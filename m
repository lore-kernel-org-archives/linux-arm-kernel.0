From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 09 May 2018 15:17:02 -0700
Subject: [PATCH v2 0/2] ARM64: dts: meson-axg: enable wifi driver
In-Reply-To: <20180504094533.15588-1-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Fri, 4 May 2018 09:45:31 +0000")
References: <20180504094533.15588-1-yixun.lan@amlogic.com>
Message-ID: <7hlgcszd7l.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun,

Yixun Lan <yixun.lan@amlogic.com> writes:

>  These patches try to enable the WIFI module AP6255 in Meson-AXG S400
> baord. First patch revert an error which was introduced in early commit.
>
> Hi Kevin
>  Please squash patch 1 into the commit[1] of your v4.18/dt64 branch,
> which was the error introduced there.

Thanks for the explanation, I've squashed patch 1, and applied patch 2
to v4.18/dt64.

Thanks,

Kevin
