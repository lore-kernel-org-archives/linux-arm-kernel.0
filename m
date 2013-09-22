From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 22 Sep 2013 14:20:28 +0200
Subject: [PATCH 11/26] ARM: dove: remove custom .init_time hook
In-Reply-To: <20130921122226.GB31180@lunn.ch>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-12-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130921122226.GB31180@lunn.ch>
Message-ID: <523EE08C.60309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2013 02:22 PM, Andrew Lunn wrote:
> On Wed, Sep 18, 2013 at 07:53:44PM +0200, Sebastian Hesselbarth wrote:
>> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
>> remove custom .init_time hooks. While at it, also remove some obsolete
>> includes.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> ---
>>   arch/arm/mach-dove/board-dt.c |   11 -----------
>>   1 file changed, 11 deletions(-)
[...]
> Boot tested on cubox.
>
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks Andrew!

Aren't you giving any Acks for dove/kirkwood anymore?

Sebastian
