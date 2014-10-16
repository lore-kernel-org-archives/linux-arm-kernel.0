From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 Oct 2014 09:27:06 -0600
Subject: [PATCH v2 45/53] dmaengine: bcm2835: Declare slave capabilities
 for the generic code
In-Reply-To: <1413454672-27400-46-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
 <1413454672-27400-46-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <543FE3CA.3090209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2014 04:17 AM, Maxime Ripard wrote:
> Now that the generic slave caps code can make use of the device assigned
> capabilities, instead of relying on a callback to be implemented.
>
> Make use of this code.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
