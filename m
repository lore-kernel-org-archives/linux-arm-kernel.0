From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 18 Sep 2013 13:37:57 -0600
Subject: [PATCH 10/26] ARM: bcm2835: remove custom .init_time hook
In-Reply-To: <1379526839-14798-11-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-11-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <523A0115.2080302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 11:53 AM, Sebastian Hesselbarth wrote:
> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove custom .init_time hooks. Also remove call to of_clk_init from
> clk-bcm2835 with core fixed_clock match, as this has already been
> registered now.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
