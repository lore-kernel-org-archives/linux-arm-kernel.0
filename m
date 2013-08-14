From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 23:30:00 -0700
Subject: [PATCH 03/10] ARM: clps711x: autcpu12: Remove incorrect config
 checking
In-Reply-To: <1374172501-26796-4-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-4-git-send-email-shc_work@mail.ru>
Message-ID: <20130814063000.GE19951@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 10:34:54PM +0400, Alexander Shiyan wrote:
> This patch removes incorrect config symbols checking since these
> symbols not contain "CONFIG_" prefix. Anyway, checking is unneeded
> here and this patch remove it completely.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.


-Olof
