From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 30 Mar 2012 12:03:53 +0530
Subject: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
In-Reply-To: <201203271619.13320.arnd@arndb.de>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <1328032576-9269-7-git-send-email-thomas.abraham@linaro.org>
 <201203271619.13320.arnd@arndb.de>
Message-ID: <4F7553D1.4030008@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/27/2012 9:49 PM, Arnd Bergmann wrote:
> These bindings came up in a discussion IRC today. I think it's rather bad that
> we can't agree on a common way to name the properties for mmc. We have
> bindings being proposed or already included from Anton, Stephen, Shawn,
> Rajendra, Viresh, Lee and Thomas. Almost all of them define GPIO pins
> for card detect and write protect, as well properties to define the bus
> width and high-speed modes, but we seem to have almost as many different
> definitions of these as we have drivers.
> 
> Can we please come up with a common binding for these?

Is there any progress on this? Sorry i wasn't following all mails.
How should i progress for sdhci-spear?

-- 
viresh
