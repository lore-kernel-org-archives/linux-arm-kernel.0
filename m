From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 02 May 2016 15:41:51 +0200
Subject: [RFT PATCH 0/3] usb: misc: usb3503: Fix missing device when TFTP
 booting
In-Reply-To: <572758B1.60202@xs4all.nl>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
 <57247E50.1020000@xs4all.nl> <20160501131746.GA16766@kozik-lap>
 <57260E1E.70205@xs4all.nl> <57262844.7060809@xs4all.nl>
 <20160501164252.GA3581@kozik-lap> <572758B1.60202@xs4all.nl>
Message-ID: <5727591F.3000100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2016 03:40 PM, Hans Verkuil wrote:
>>> Anyway, after disabling that config option I was finally able to test your patch
>>> series:
>>>
>>> Tested-by: Hans Verkuil <hans.verkuil@cisco.com>
> 
> BTW, one thing I noticed is that to have u-boot detect the network device I
> need to call 'usb reset' twice. This is with u-boot 2016.1 release.
> 
> Not a big deal, but I wondered if you see the same.

Yes, I also have to do it twice.

Best regards,
Krzysztof
