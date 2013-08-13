From: msalter@redhat.com (Mark Salter)
Date: Tue, 13 Aug 2013 09:57:31 -0400
Subject: [PATCH 10/16] Move EFI_READ_CHUNK_SIZE define to shared location.
In-Reply-To: <1376090777-20090-11-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-11-git-send-email-roy.franz@linaro.org>
Message-ID: <1376402251.27484.20.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> This #define is only used the the shared code, so move
> it there.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---

Tested on arm64.

Acked-by: Mark Salter <msalter@redhat.com>
