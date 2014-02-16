From: broonie@kernel.org (Mark Brown)
Date: Sun, 16 Feb 2014 09:58:07 +0800
Subject: [RFC PATCH 1/3] regmap: Separate regmap dev initialization
In-Reply-To: <5998a942a3dbfb2ef965d000168cbd7007315630.1392045742.git.michal.simek@xilinx.com>
References: <cover.1392045742.git.michal.simek@xilinx.com>
 <5998a942a3dbfb2ef965d000168cbd7007315630.1392045742.git.michal.simek@xilinx.com>
Message-ID: <20140216015807.GX4451@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 04:22:33PM +0100, Michal Simek wrote:
> Create special function regmap_attach_dev
> which can be called separately out of regmap_init.

Applied, thanks.  I've pushed a signed tag too so dependencies can pull
this in:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/nodev

When sending things like this that add new functionality it's often
helpful to send the patches adding users to review along with the core
patch since this helps to review if the usage is actually sane and
sensible.  From a purely regmap point of view this seems OK but...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140216/0d9e2231/attachment.sig>
