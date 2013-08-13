From: msalter@redhat.com (Mark Salter)
Date: Tue, 13 Aug 2013 09:56:56 -0400
Subject: [PATCH 04/16] Add minimum address parameter to efi_low_alloc()
In-Reply-To: <1376090777-20090-5-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-5-git-send-email-roy.franz@linaro.org>
Message-ID: <1376402216.27484.15.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> This allows allocations to be made low in memory while
> avoiding allocations at the base of memory.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---

Tested on arm64.

Acked-by: Mark Salter <msalter@redhat.com>
