From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 14:12:57 -0800
Subject: [PATCH 6/7] drm/sun4i: Save newly created layer in layers array
 in sun4i_layers_init
In-Reply-To: <20170217031330.14087-7-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
 <20170217031330.14087-7-wens@csie.org>
Message-ID: <20170221221257.exuzq7sdnlo3qsqs@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 11:13:29AM +0800, Chen-Yu Tsai wrote:
> sun4i_layers_init allocates an array to store pointers to newly created
> layers returned by sun4i_layer_init_one(), but fails to actually store
> them. But it actually returns the empty array to unsuspecting users.
> 
> Save the pointers in the array, so that they may be used later.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/36c136e1/attachment.sig>
