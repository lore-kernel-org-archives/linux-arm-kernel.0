From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Mar 2017 13:43:23 +0000
Subject: Applied "ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE"
 to the asoc tree
In-Reply-To: <CAGb2v6428PpYPzpHngLgaeziwKN8u-TYiNO1bs7TFw-7VrQOAg@mail.gmail.com>
References: <20170210094133.11382-3-mylene.josserand@free-electrons.com>
 <E1clbY9-0000DH-LY@finisterre>
 <CAGb2v6428PpYPzpHngLgaeziwKN8u-TYiNO1bs7TFw-7VrQOAg@mail.gmail.com>
Message-ID: <20170315134323.i3pvla3pzejmkxwh@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 12:31:22PM +0800, Chen-Yu Tsai wrote:
> On Wed, Mar 8, 2017 at 9:22 PM, Mark Brown <broonie@kernel.org> wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> This patch changes the mixer controls exposed to user space.

> This driver was just introduced in 4.11-rc1. Would it make sense to
> merge these cleanup patches as fixes for 4.11, so we don't affect
> userspace across kernel releases?

It would but it doesn't pick over cleanly, it looks like it depends on
some of the other changes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/e8c39855/attachment-0001.sig>
