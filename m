From: msalter@redhat.com (Mark Salter)
Date: Tue, 13 Aug 2013 09:56:20 -0400
Subject: [PATCH 01/16] Move common EFI stub code from x86 arch code to
 common location
In-Reply-To: <1376090777-20090-2-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-2-git-send-email-roy.franz@linaro.org>
Message-ID: <1376402180.27484.12.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> No code changes made, just moving functions from x86 arch directory
> to common location.
> Code is shared using #include, similar to how decompression code
> is shared among architectures.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---

Tested on arm64.

Acked-by: Mark Salter <msalter@redhat.com>
