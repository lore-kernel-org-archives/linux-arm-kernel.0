From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Mar 2017 19:53:37 +0800
Subject: [PATCH v3 5/5] ARM: dts: sun8i: Update audio-routing with renamed
 widgets
In-Reply-To: <20170320113817.rcphcvrizi4yphhe@sirena.org.uk>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-6-mylene.josserand@free-electrons.com>
 <20170320113817.rcphcvrizi4yphhe@sirena.org.uk>
Message-ID: <CAGb2v66ZLeoSQt0y2QVcDEBujS7JLQAptDq1WL8f8rkwSni6uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 7:38 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Mar 18, 2017 at 08:55:09AM +0100, Myl?ne Josserand wrote:
>> The digital AIF interfaces has been renamed in the sun8i audio codec
>> driver so the audio-routing in the device tree must be renamed too.
>
> Given that these are fixes it probably makes sense that they all go in
> together, can I get some acks for this and I'll apply it?

Acked-by: Chen-Yu Tsai <wens@csie.org>

Though this patch should go in through the arm-soc tree.
