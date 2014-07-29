From: andrea.adami@gmail.com (Andrea Adami)
Date: Wed, 30 Jul 2014 00:06:38 +0200
Subject: [PATCH v2] spi/pxa2xx-pci: Add common clock framework support in
 PCI glue layer
In-Reply-To: <20140729185529.GG17528@sirena.org.uk>
References: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
 <20140725053230.GT1857@lahna.fi.intel.com>
 <CAAQYJAtM79NJJtfNYda-yFk113nm-2D8gZE5x=gbnLt2_eUdzQ@mail.gmail.com>
 <20140729185529.GG17528@sirena.org.uk>
Message-ID: <CAAQYJAtLVgqbs=n2gxyemDAoHhM=7PFJy9bqKUExTbC+1rSNMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 8:55 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 29, 2014 at 06:13:06PM +0200, Andrea Adami wrote:
>
>> note that a previous version of the patch breaks spi on pxa machines:
>> tested on pxa250 poodle and pxa255 corgi.
>> The patch is included in linux-Yocto since 3.14.
>
> The interesting question is if this version works...

Happy to report that I could finally test on poodle/pxa250 the current
v2 and the patch doesn't seem to disturb the probe.
Sorry for the noise.

Andrea
