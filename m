From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 22 Nov 2013 13:09:24 -0800
Subject: [PATCH 2/5] net: MOXA ART: connect to PHY and add ethtool support
In-Reply-To: <CACmBeS3vyLT7MYeTM6OzYvpWdqJgHp=ys0acf-qun14pbc=oXQ@mail.gmail.com>
References: <1385132242-3204-1-git-send-email-jonas.jensen@gmail.com>
 <1385132242-3204-2-git-send-email-jonas.jensen@gmail.com>
 <CACmBeS3vyLT7MYeTM6OzYvpWdqJgHp=ys0acf-qun14pbc=oXQ@mail.gmail.com>
Message-ID: <CAGVrzcYC48enOr3nbXVVNQh0XzuDLu=hpAUqKHMEpABdiCYUAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/11/22 Jonas Jensen <jonas.jensen@gmail.com>:
> On 22 November 2013 15:57, Jonas Jensen <jonas.jensen@gmail.com> wrote:
>>  drivers/net/ethernet/moxa/moxart_ether.c | 179 ++++++++++++++++++++++++++++++-
>>  drivers/net/ethernet/moxa/moxart_ether.h |   1 +
>>  2 files changed, 179 insertions(+), 1 deletion(-)
>
> I see now I forgot to include the devicetree binding document.
>
> I'll wait for comments.

You are doing two things in your patch, so that means two separate patches.
-- 
Florian
