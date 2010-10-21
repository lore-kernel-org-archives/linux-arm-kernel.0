From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 21 Oct 2010 16:11:38 +0200
Subject: [PATCH v2 1/2] [ARM] Kirkwood: enhance TCLK detection
In-Reply-To: <1287654149-8743-1-git-send-email-simon@sequanux.org>
References: <20101020085720.GA12979@mail.wantstofly.org>
	<1287654149-8743-1-git-send-email-simon@sequanux.org>
Message-ID: <20101021141138.GG22363@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 21, 2010 at 11:42:28AM +0200, Simon Guinot wrote:

> From: Simon Guinot <sguinot@lacie.com>
> 
> According to the Marvell LSP, the Sample at Reset regiter bit 21 can be
> used to detect TCLK on 6281 and 6282 devices.
> 
> This patch has only been tested on LaCie boards.
> 
> Signed-off-by: Simon Guinot <sguinot@lacie.com>

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
