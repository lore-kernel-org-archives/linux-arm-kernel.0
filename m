From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Feb 2017 16:00:10 -0600
Subject: [PATCH 1/2] power: reset: syscon-poweroff: add a mask property
In-Reply-To: <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
References: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
Message-ID: <20170215220010.psk37r4belykyquy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 05:56:05PM +0200, Guy Shapiro wrote:
> Make the syscon-poweroff driver accept value and mask instead of
> just value.
> 
> Prior to this patch, the property name for the value was 'mask'. If
> only the mask property is defined on a node, maintain compatibility
> by using it as the value.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
> ---
>  .../bindings/power/reset/syscon-poweroff.txt          | 11 +++++++++--
>  drivers/power/reset/syscon-poweroff.c                 | 19 ++++++++++++++++---
>  2 files changed, 25 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
