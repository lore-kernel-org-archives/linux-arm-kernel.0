From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 11 Aug 2017 21:08:40 +0200
Subject: [PATCH 10/11] ASoC: pxa: Handle return value of
 clk_prepare_enable.
References: <1500977770-28142-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <874ltdq5vr.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arvind Yadav <arvind.yadav.cs@gmail.com> writes:

> clk_prepare_enable() can fail here and we must check its return value.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
