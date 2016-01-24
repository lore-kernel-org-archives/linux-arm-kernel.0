From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 24 Jan 2016 13:41:59 -0800
Subject: [PATCH] arm64: fix off-by-one in compat syscall table for
 syscalls over 382
In-Reply-To: <20160118122447.GE3693@arm.com>
References: <1450804573-322-1-git-send-email-will.deacon@arm.com>
 <20160118122447.GE3693@arm.com>
Message-ID: <20160124214159.GB9841@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 12:24:48PM +0000, Will Deacon wrote:
> Greg, Sasha,
> 
> Is there anything else I need to do to get this queued in the 3.17.y
> and 3.18.y stable trees? There's no corresponding upstream commit since
> the issue was fixed by accident in 3.19+ as a result of something else.

I'm not releasing any 3.17.y or 3.18.y kernels, so there's nothing I can
do here, sorry.

greg k-h
