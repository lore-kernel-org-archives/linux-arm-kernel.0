From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon, 09 Dec 2013 18:42:51 +0400
Subject: [PATCH 3/9] ARM: fix ohci-pxa27x build error with OF enabled
In-Reply-To: <20131209142605.GA9345@s.cotton.clara.co.uk>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-4-git-send-email-ynvich@gmail.com>
 <20131209142605.GA9345@s.cotton.clara.co.uk>
Message-ID: <1386600171.7152.165.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-09 at 14:26 +0000, Steve Cotton wrote:
> There's already a different patch for this
> in the linux-next/master and gregkh/usb/usb-linus trees, but
> not in the linux-next/stable or gregkh/usb/usb-next trees.
> 
> It adds that include 3 lines higher up, to keep the includes in
> alphabetical order.

Thanks.
