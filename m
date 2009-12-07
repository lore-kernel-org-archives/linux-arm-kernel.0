From: gregkh@suse.de (Greg KH)
Date: Sun, 06 Dec 2009 16:01:08 -0800
Subject: [092/119] [ARM] pxamci: call mmc_remove_host() before freeing
	resources
In-Reply-To: <20091207000938.GA24743@kroah.com>
References: <20091206235936.208334321@mini.kroah.org>
Message-ID: <20091207000657.032254620@mini.kroah.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An embedded and charset-unspecified text was scrubbed...
Name: pxamci-call-mmc_remove_host-before-freeing-resources.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091206/df934888/attachment.el>
