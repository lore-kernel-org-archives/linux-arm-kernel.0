From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 17 Jul 2012 14:07:29 +0100
Subject: Device tree.
In-Reply-To: <CAMW5UfZR5qrY4K=ty9HDcd9UqYGtfZitH0CBgDbZWvpAoTve2Q@mail.gmail.com>
References: <500552C9.4090107@codethink.co.uk> <20120717140100.7c0ae90c@skate>
 <500556CF.6030704@codethink.co.uk>
 <CAMW5UfZR5qrY4K=ty9HDcd9UqYGtfZitH0CBgDbZWvpAoTve2Q@mail.gmail.com>
Message-ID: <50056391.3060208@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/12 13:32, Josh Coombs wrote:
> make make target.dtb
> cat arch/arm/boot/target.dtb  >> arch/arm/boot/zImage
 >make uImage

Yick...

 >My understanding is you can
 > only append one DTB, there is no restriction on how many systems a
 > given kernel could support, so at the moment there isn't a clean way
 > of defining which DTB to append during make uImage? Josh C

Yes, hence why it'd be useful to have a way of specifying a .dtb file as 
a config option...

There isnt really a good way to solve this, AFAICT.

-Ian
