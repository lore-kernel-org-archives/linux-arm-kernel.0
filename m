From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 3 May 2016 14:58:20 -0700
Subject: [PATCH 01/27] coresight: no need to do the forced type conversion
In-Reply-To: <1462296841-12327-2-git-send-email-mathieu.poirier@linaro.org>
References: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
 <1462296841-12327-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20160503215820.GA21470@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 11:33:35AM -0600, Mathieu Poirier wrote:
> From: lipengcheng <lipengcheng8@huawei.com>

That name, doesn't match:

> 
> activated and enable are already unsigned type,
> no need to change them to unsigned.
> 
> Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>

That name :(

Please be more careful here.

I'll edit this by hand this time :(
