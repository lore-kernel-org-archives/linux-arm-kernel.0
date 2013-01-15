From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 15 Jan 2013 10:58:30 -0300
Subject: [PATCH 2/6] arm: mvebu: Enable USB controllers on Armada 370
 evaluation board
In-Reply-To: <201301151307.26665.arnd@arndb.de>
References: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358243670-11935-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <201301151307.26665.arnd@arndb.de>
Message-ID: <50F56086.2040101@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 01/15/2013 10:07 AM, Arnd Bergmann wrote:
> On Tuesday 15 January 2013, Ezequiel Garcia wrote:
>> Cc: Lior Amsalem <alior@marvell.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> The patches look good, but when you have four trivial patches
> doing the same thing in different files, and you decide that it's
> not worth writing a changelog for them, they should probably
> go into a single patch.
>

Mmm... maybe you're right and such splitting is excessive.
It seemed tidier this way, enabling each board on a different patch.

I can squash them on a v2, if you want me to.

Thanks for reviewing!

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
