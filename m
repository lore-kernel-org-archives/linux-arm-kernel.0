From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 7 Mar 2012 11:34:14 +0100
Subject: [PATCH 00/15] watchdog/mpcore: updates & fixes
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
Message-ID: <20120307103414.GA2568@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> This patchset contains fixes and updates for ARM mpcore watchdog driver.

It probably makes sense to convert this to use the watchdog-core. See
Documentation/watchdog/convert_drivers_to_kernel_api.txt for some
guidance.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120307/92387fc2/attachment-0001.sig>
