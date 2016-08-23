From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 Aug 2016 17:50:09 +0200
Subject: [PATCH -next] net: phy: xgmiitorgmii: Fix non static symbol
 warning
In-Reply-To: <874c4fd0-ac5d-9db0-3470-e092b9251cd7@gmail.com>
References: <1471964765-32708-1-git-send-email-weiyj.lk@gmail.com>
 <20160823151619.GK20029@lunn.ch>
 <874c4fd0-ac5d-9db0-3470-e092b9251cd7@gmail.com>
Message-ID: <20160823155009.GM20029@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 11:41:25PM +0800, Wei Yongjun wrote:
> Hi Andrew,
> 
> On 08/23/2016 11:16 PM, Andrew Lunn wrote:
> > On Tue, Aug 23, 2016 at 03:06:05PM +0000, Wei Yongjun wrote:
> >> From: Wei Yongjun <weiyongjun1@huawei.com>
> > Hi Wei
> >
> > No need for the additional From:
> >
> > git am will use the one in the mail header as the author of the patch,
> > and it is in the signed-off-by as well.
> 
> The mail address which I sent the patch is different with the
> signed-of-by one, so git send-email will not remove the From line.

Cool. git am strips it out of the commit message and uses it as the
Author. I didn't know it did that.

Sorry for the noise, 

	Andrew
