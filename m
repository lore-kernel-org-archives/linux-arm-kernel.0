From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Wed, 17 Feb 2016 02:33:44 +0000
Subject: [PATCH 5/7] serial: clps711x: fix IS_ERR_VALUE usage
In-Reply-To: <1455546925-22119-6-git-send-email-a.hajda@samsung.com>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
 <1455546925-22119-6-git-send-email-a.hajda@samsung.com>
Message-ID: <20160217023344.GJ17997@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 03:35:23PM +0100, Andrzej Hajda wrote:
> IS_ERR_VALUE macro should be used only with unsigned long type.
> For signed types comparison 'ret < 0' should be used.

ACK
