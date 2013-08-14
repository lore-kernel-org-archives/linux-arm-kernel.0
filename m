From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 23:30:15 -0700
Subject: [PATCH 04/10] ARM: clps711x: edb7211: Remove extra
 iotable_init() call
In-Reply-To: <1374172501-26796-5-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-5-git-send-email-shc_work@mail.ru>
Message-ID: <20130814063015.GF19951@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 10:34:55PM +0400, Alexander Shiyan wrote:
> The keyboard driver for the CLPS711X platform is missing, so there
> is no need to call iotable_init() for this memory region.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>


Applied, thanks.


-Olof
