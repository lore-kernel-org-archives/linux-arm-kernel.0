From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 3 Oct 2012 16:23:11 -0700
Subject: [PATCH v3] Enable USB peripheral on dm365 EVM
In-Reply-To: <1349301859-31306-1-git-send-email-const@MakeLinux.com>
References: <1349301859-31306-1-git-send-email-const@MakeLinux.com>
Message-ID: <20121003232311.GA14392@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 12:04:19AM +0200, const at MakeLinux.com wrote:
> From: Constantine Shulyupin <const@MakeLinux.com>
> 
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
> Tested with usb gadget g_zero.
> This patch is based on code from Arago, Angstom, and RidgeRun projects.
> Original patch is three years ago:
> http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg14741.html

You can't have two "From:" lines.

And put the information above, in the changelog entry.

Also, it looks like you are modifying printk lines for no reason, why do
that in this patch?  That shouldn't be needed, right?

greg k-h
