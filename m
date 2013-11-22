From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Fri, 22 Nov 2013 16:20:17 +0100
Subject: [PATCH 2/5] net: MOXA ART: connect to PHY and add ethtool support
In-Reply-To: <1385132242-3204-2-git-send-email-jonas.jensen@gmail.com>
References: <1385132242-3204-1-git-send-email-jonas.jensen@gmail.com>
 <1385132242-3204-2-git-send-email-jonas.jensen@gmail.com>
Message-ID: <CACmBeS3vyLT7MYeTM6OzYvpWdqJgHp=ys0acf-qun14pbc=oXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2013 15:57, Jonas Jensen <jonas.jensen@gmail.com> wrote:
>  drivers/net/ethernet/moxa/moxart_ether.c | 179 ++++++++++++++++++++++++++++++-
>  drivers/net/ethernet/moxa/moxart_ether.h |   1 +
>  2 files changed, 179 insertions(+), 1 deletion(-)

I see now I forgot to include the devicetree binding document.

I'll wait for comments.


Thanks,
Jonas
