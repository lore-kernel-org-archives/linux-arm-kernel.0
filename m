From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 24 Mar 2013 21:13:37 +0000
Subject: [PATCH v10 0/12] Palmas updates
In-Reply-To: <20130323060455.78a4c90c3f1e028434818fd1@canb.auug.org.au>
References: <1363964122-19201-1-git-send-email-ian@slimlogic.co.uk>
 <20130323060455.78a4c90c3f1e028434818fd1@canb.auug.org.au>
Message-ID: <20130324211336.GA18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 06:04:55AM +1100, Stephen Rothwell wrote:
> On Fri, 22 Mar 2013 14:55:10 +0000 Ian Lartey <ian@slimlogic.co.uk> wrote:

> > Patches based on linux-next-20130319

> I can't really comment on the patch set except to say that you should not
> base on linux-next, you should base on the tree to which you expect the
> patch set to be applied.

It's fairly common to suggest to people working over lots of subsystems
like this that they use -next since for most subsystems it contains the
trees that should be submitted against and it's much more efficient.
This works OK most of the time when people are posting patches as
opposed to pull requests, though obviously cross tree issues do happen
from time to time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130324/e88a0cbc/attachment.sig>
