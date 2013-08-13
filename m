From: msalter@redhat.com (Mark Salter)
Date: Tue, 13 Aug 2013 09:57:44 -0400
Subject: [PATCH 12/16] Fix types in EFI calls to match EFI function
 definitions.
In-Reply-To: <1376090777-20090-13-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-13-git-send-email-roy.franz@linaro.org>
Message-ID: <1376402264.27484.22.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> EFI calls can made directly on ARM, so the function pointers
> are directly invoked.  This allows types to be checked at
> compile time, so here we ensure that the parameters match
> the function signature.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---

Tested on arm64.

Acked-by: Mark Salter <msalter@redhat.com>
