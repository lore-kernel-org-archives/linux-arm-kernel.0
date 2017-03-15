From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 15 Mar 2017 22:15:22 +0800
Subject: Applied "ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE"
 to the asoc tree
In-Reply-To: <20170315134323.i3pvla3pzejmkxwh@sirena.org.uk>
References: <20170210094133.11382-3-mylene.josserand@free-electrons.com>
 <E1clbY9-0000DH-LY@finisterre>
 <CAGb2v6428PpYPzpHngLgaeziwKN8u-TYiNO1bs7TFw-7VrQOAg@mail.gmail.com>
 <20170315134323.i3pvla3pzejmkxwh@sirena.org.uk>
Message-ID: <CAGb2v67-b+8CM0MqhT_YQeuNxEnVoxG-COZPy8LW32Eb-QE67Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 9:43 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 14, 2017 at 12:31:22PM +0800, Chen-Yu Tsai wrote:
>> On Wed, Mar 8, 2017 at 9:22 PM, Mark Brown <broonie@kernel.org> wrote:
>> This patch changes the mixer controls exposed to user space.
>
>> This driver was just introduced in 4.11-rc1. Would it make sense to
>> merge these cleanup patches as fixes for 4.11, so we don't affect
>> userspace across kernel releases?
>
> It would but it doesn't pick over cleanly, it looks like it depends on
> some of the other changes.

It depends on the second half of commit 4aa8146c89f3 ("ASoC: sun8i-codec:
Remove analog "HP" widget"), which is also a cleanup. Would it be OK
to pick these two over to fixes then? Or should we send a clean version
instead?

ChenYu
