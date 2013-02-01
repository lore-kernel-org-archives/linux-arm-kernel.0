From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Jan 2013 19:57:48 -0800
Subject: [PATCH] clocksource: always define CLOCKSOURCE_OF_DECLARE
In-Reply-To: <1359568170-26479-1-git-send-email-swarren@wwwdotorg.org>
References: <1359568170-26479-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130201035748.GB5844@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 10:49:30AM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This allows clocksource drivers that support both DT and non-DT to
> always invoke macro CLOCKSOURCE_OF_DECLARE(), rather than wrapping
> it in a #ifdef CONFIG_CLKSRC_OF, which simplifies their code.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Olof, Arnd, this is based on arm-soc's timer/cleanup branch, which is
> probably the best place for this patch.

Applied (to next/cleanup).


-Olof
