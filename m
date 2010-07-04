From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 4 Jul 2010 23:56:46 +0800
Subject: [PATCH 26/33] Removing dead XSCALE_CACHE_ERRATA
In-Reply-To: <AANLkTikhv1JxmAS8wYksEELII-5YzKi-a5by0EV_ESYH@mail.gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<e9515441013afc8e866f3081dd35bbe0122ece5e.1277911346.git.siccegge@cs.fau.de>
	<AANLkTikhv1JxmAS8wYksEELII-5YzKi-a5by0EV_ESYH@mail.gmail.com>
Message-ID: <AANLkTilRaITmDNfN03RyA4Hj9EmIFnDIy6KbOPlaLzdu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 1, 2010 at 12:25 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, Jul 1, 2010 at 12:02 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
>> XSCALE_CACHE_ERRATA doesn't exist in Kconfig, therefore removing all
>> references for it from the source code.
>>
>> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
>
> Acked-by: Eric Miao <eric.y.miao@gmail.com>
>
> It's not been there since 2.6, found some references in 2.4 kernel though. And
> I doubt anyone has encountered this issue in real products on market.
>

Applied.
