From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Mar 2012 12:31:30 +0000
Subject: [PATCH v10] Regulator: Add Anatop regulator driver
In-Reply-To: <20120309095834.GM27213@game.jcrosoft.org>
References: <1331200744-5986-1-git-send-email-paul.liu@linaro.org>
 <20120308141847.GG27213@game.jcrosoft.org>
 <4F59B899.2080704@linaro.org>
 <20120309095834.GM27213@game.jcrosoft.org>
Message-ID: <20120309123130.GO3273@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 10:58:34AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> > I've modify the patch based on your review. However, the last one cannot
> > be made because regulator_unregister is void return.

> so we have a issue here regulator_unregister MUST return an error conde

The error handling on remove is totally irrelevant to merging this
driver.  If you want to work on changing this in the core you're more
than welcome to spend your time on it, I'm really not sure it's really
worth the time or effort for the systems we currently have, if someone
actually has a system where it becomes relevant then they can work on
it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/7540dfe6/attachment-0001.sig>
