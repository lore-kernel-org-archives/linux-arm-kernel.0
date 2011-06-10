From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Jun 2011 14:48:21 +0100
Subject: [PATCH] arm, exec: remove redundant set_fs(USER_DS)
In-Reply-To: <1307711337-4042-1-git-send-email-minipli@googlemail.com>
References: <BANLkTiknCeAxe30MJdVTxDom+ko8+EDQ4A@mail.gmail.com>
	<1307642718-22257-1-git-send-email-minipli@googlemail.com>
	<20110609155630.0f734351.akpm@linux-foundation.org>
	<1307711337-4042-1-git-send-email-minipli@googlemail.com>
Message-ID: <20110610134821.GL24424@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 03:08:57PM +0200, Mathias Krause wrote:
> The address limit is already set in flush_old_exec() so this
> set_fs(USER_DS) is redundant.

Please show where and how this is done.  I've looked and can't see
any equivalent call to set_fs() in flush_old_exec().
