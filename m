From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 23 Sep 2013 00:34:09 +0400
Subject: [PATCH] ARM: drop <asm/types.h> from generic-y
In-Reply-To: <1379868215-15270-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1379868215-15270-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <523F5441.6000407@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09/22/2013 08:43 PM, Ard Biesheuvel wrote:

> Commit 09096f6 introduced an ARM specific <asm/types.h> to work

    Please also specify that commit's summary line in parens.

> around some ambiguities in the definitions of 32 bit types.
> Hence, we will not be needing the generic version anymore.

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

WBR, Sergei
