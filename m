From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Dec 2012 15:50:32 -0700
Subject: [PATCH v2] pinctrl: add sleep mode management
In-Reply-To: <1355515233-23663-1-git-send-email-linus.walleij@stericsson.com>
References: <1355515233-23663-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50CBAD38.1030104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2012 01:00 PM, Linus Walleij wrote:
> This fix allows handling sleep mode for hogged
> pins in pinctrl. It provides functions to set pins
> to sleep/default configurations according to their
> current state.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
