From: codekipper@gmail.com (Code Kipper)
Date: Tue, 30 Aug 2016 08:49:40 +0200
Subject: [linux-sunxi] [PATCH v9 2/2] Add mixer controls: Line-In, FM-In,
 Mic 2, Capture Source, Differential Line-In.
In-Reply-To: <20160829180321.11695-3-dannym@scratchpost.org>
References: <20160829180321.11695-1-dannym@scratchpost.org>
 <20160829180321.11695-3-dannym@scratchpost.org>
Message-ID: <CAEKpxBn9AbxHQE03BVtR4NuF-KzqE_0-+nLGqcSyNrc=nbQgow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 August 2016 at 20:03, Danny Milosavljevic <dannym@scratchpost.org> wrote:
>
> Note: Mic1 Capture Volume is in a different register on A20 than on A10.
> Note: Mic2 Capture Volume is in a different register on A20 than on A10.
> ---
>  sound/soc/sunxi/sun4i-codec.c | 256 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 236 insertions(+), 20 deletions(-)
Hi Danny,
I think this should be delivered in a series of patches like what I've
attempted to do here
https://github.com/codekipper/linux-sunxi/commits/sunxi-wip?page=2
I haven't worked with my A20 for a while which is why I haven't
delivered these changes, however summer is coming to an end and should
be able to retest and deliver soon.
I can see that there is a difference like you've mentioned between the
A10 and A20 with the MIC pre-amps so approve of the use of a common
array.
Something also looks wrong with the whitespacing for sun4i_codec_codec.
BR,
CK
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
