From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 21 Dec 2013 13:06:38 -0800
Subject: [PATCH V2 0/4] misc: xgene: Add support for APM X-Gene SoC Queue
 Manager/Traffic Manager
In-Reply-To: <1387594651-25771-1-git-send-email-rapatel@apm.com>
References: <1387594651-25771-1-git-send-email-rapatel@apm.com>
Message-ID: <20131221210638.GA30102@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 06:57:27PM -0800, Ravi Patel wrote:
> This patch adds support for APM X-Gene SoC Queue Manager/Traffic Manager.
>  QMTM is required by APM X-Gene SoC Ethernet, PktDMA (XOR Engine) and
>  Security Engine subsystems. All subsystems communicate with QMTM using
>  messages which include information about the work to be performed and
>  the location of associated data buffers.  

As you failed to respond or even acknowledge any of my review comments
before, I don't understand what you expect me to do with this patch dump
again.

Remember, kernel development is about trust.  You need me to trust that
you know what you are doing, and will be able to handle feedback and
respond to issues that come up over time.  Right now that trust is in
the negative zone, around "general annoyance" levels.  It's up to you to
change that or not, just like it is up to me to take your code, or not.

grumble,

greg k-h
