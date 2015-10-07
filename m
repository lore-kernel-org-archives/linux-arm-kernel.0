From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 7 Oct 2015 17:53:39 +0100
Subject: [PATCH 5/6] coresight: etm3x: breaking down sysFS status interface
In-Reply-To: <1444231603-26676-6-git-send-email-mathieu.poirier@linaro.org>
References: <1444231603-26676-1-git-send-email-mathieu.poirier@linaro.org>
 <1444231603-26676-6-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20151007165339.GB12439@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 09:26:42AM -0600, Mathieu Poirier wrote:
> SysFS rules stipulate that only one value can be conveyed per
> file.  As such splitting the "status" interface in individual files.
> 
> This is also useful for user space applications - that way they can
> probe each file individually rather than having to parse a list of entries.

Ah, much nicer, thanks for doing this.

greg k-h
