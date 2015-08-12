From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 12 Aug 2015 09:32:40 +0800
Subject: [PATCH v2 2/2] i2c: mediatek: Fixup i2c ack error interrupt
 handling
In-Reply-To: <20150811145521.GB1525@katana>
References: <1438845731-17805-1-git-send-email-eddie.huang@mediatek.com>
 <1438845731-17805-3-git-send-email-eddie.huang@mediatek.com>
 <20150811145521.GB1525@katana>
Message-ID: <CAGS+omBrDWd7hwn=0qYBLK=6L-hORwrKQ9ecL4k3wSSGEPZ64g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tue, Aug 11, 2015 at 10:55 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Aug 06, 2015 at 03:22:11PM +0800, Eddie Huang wrote:
>> When occur i2c ack error, i2c controller generate two interrupts,
>> first is the ack error interrupt, then the complete interrupt.
>> i2c interrupt handler should keep the two interrupt value, and only
>> call complete() for the complete interrupt.
>>
>> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>
> Applied to for-next, thanks!

I don't see them in [0].
[0] https://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/log/?h=i2c/for-next

Am I not looking in the right place?
Or, did I not wait long enough?

Thanks!
-Dan
