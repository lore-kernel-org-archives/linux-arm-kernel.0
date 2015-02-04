From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Feb 2015 11:13:49 +0000
Subject: [RFC PATCH] ASoC: wm8731: let codec to manage clock by itself
In-Reply-To: <54D195D9.4090101@atmel.com>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
 <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
 <20150203124441.GK21293@sirena.org.uk>
 <CAOLZvyEVQmqg9Jn5Kt_2m5K0-taJcGf6mweK4T=fwKOwn-Ovxg@mail.gmail.com>
 <20150203162128.GP21293@sirena.org.uk> <54D195D9.4090101@atmel.com>
Message-ID: <20150204111349.GV21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 11:45:29AM +0800, Bo Shen wrote:

> Do you mean I send my RFC patch as the formal patch, and let other boards
> which use the wm8731 to add clk object, am I right?

No, we need to keep the boards working so we either need patches adding
the fixed clocks for existing boards or we need to have the handling of
missing clocks that Manuel suggested.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150204/f3afd7d7/attachment.sig>
