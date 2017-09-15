From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 15 Sep 2017 23:03:47 +0200
Subject: [PATCH 2/2] arm: dts: stm32: remove useless clocksource nodes
In-Reply-To: <1505375812-19037-3-git-send-email-benjamin.gaignard@linaro.org>
References: <1505375812-19037-1-git-send-email-benjamin.gaignard@linaro.org>
 <1505375812-19037-3-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <20170915210347.GA1831@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 09:56:52AM +0200, Benjamin Gaignard wrote:
> 16 bits timers aren't accurate enough to be used as
> clocksource, remove them from stm32f4 and stm32f7 devicetree.

Do you really want to remove the description? The timers are disabled, aren't they?
