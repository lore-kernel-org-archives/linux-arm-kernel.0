From: pratyush.anand@st.com (Pratyush Anand)
Date: Fri, 24 Feb 2012 09:52:46 +0530
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <201202231301.39345.sr@denx.de>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <20120223111906.GS22562@n2100.arm.linux.org.uk> <4F462444.8060406@st.com>
 <201202231301.39345.sr@denx.de>
Message-ID: <4F471096.6010506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/23/2012 5:31 PM, Stefan Roese wrote:
> Did you notice this recent thread on the USB devel list?
>
> http://www.spinics.net/lists/linux-usb/msg58420.html
>
> I just wanted to make sure, that you don't continue working on this big and
> ugly dwc_otg driver (yes, I worked on it as well), when it has small to zero
> chances for upstreaming. Better to consolidate all efforts on this "smaller"
> driver with the other SoC vendors (Samsung etc).

Nice to know that a driver exists in main line under different name.
Will discuss about it on linux-usb mailing list.

Thanks & Regards
Pratyush
