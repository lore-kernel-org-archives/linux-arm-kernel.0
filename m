From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Jun 2013 16:44:44 -0600
Subject: [PATCH 4/7] of: introduce of_parse_phandle_with_fixed_args
In-Reply-To: <1371157199-7272-4-git-send-email-swarren@wwwdotorg.org>
References: <1371157199-7272-1-git-send-email-swarren@wwwdotorg.org>
 <1371157199-7272-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51C4D75C.9060007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2013 02:59 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This is identical to of_parse_phandle_with_args(), except that the
> number of argument cells is fixed, rather than being parsed out of the
> node referenced by each phandle.

Rob, Grant, are you OK with these two DT patches? LinusW would like an
ack so he can take the series, which implements gpio-ranges property
parsing cleanup, through the GPIO tree. Thanks.
