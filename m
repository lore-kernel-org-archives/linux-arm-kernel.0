From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 5 Feb 2017 01:29:43 +0100
Subject: [PATCH] somedriver: remove the initialization of static pointers.
In-Reply-To: <1486237182-4563-1-git-send-email-abdallah.meziti.pro@gmail.com>
References: <1486237182-4563-1-git-send-email-abdallah.meziti.pro@gmail.com>
Message-ID: <20170205002943.GA21184@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 04, 2017 at 08:39:21PM +0100, AbdAllah-MEZITI wrote:
> In C a static pointer will be initialized to NULL (e.g: draft C99 standard $6.7.8):
> "If an object that has static storage duration is not initialized
> explicitly, then:
>  __ if it has pointer type, it is initialized to a null pointer;"
> 
> Signed-off-by: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>

Your subject is very odd :(

And is that the correct spelling of your name that you use for legal
documents?  If not, please fix up when you resend this.

Also, fix the line-wrapping of your changelog, and the C99 standard is
not a "draft" anymore, it was released in 1999 :)

thanks,

greg k-h
