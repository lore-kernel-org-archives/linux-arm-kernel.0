From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 18 Jul 2013 13:34:11 +0200
Subject: [PATCH v4 5/5] ASoC: atmel-ssc: remove clk_disable_unprepare
 call from critical section
In-Reply-To: <20130718112538.GM22506@sirena.org.uk>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
 <1374133720-27362-1-git-send-email-b.brezillon@overkiz.com>
 <20130718112538.GM22506@sirena.org.uk>
Message-ID: <51E7D2B3.5070006@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/2013 13:25, Mark Brown wrote:
> On Thu, Jul 18, 2013 at 09:48:40AM +0200, Boris BREZILLON wrote:
>> clk_prepare/unprepare (and indirectly clk_prepare_enable/disable_unprepare)
>> may sleep and thus cannot be called in critical section.
> Applied, thanks.
Thanks
