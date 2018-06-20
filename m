From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 20 Jun 2018 08:42:23 +0800
Subject: [PATCH v3 24/27] devicetree: fix a series of wrong file references
In-Reply-To: <bce1b59268ac2d659fd7cb37f89285ef2acc8316.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <bce1b59268ac2d659fd7cb37f89285ef2acc8316.1528990947.git.mchehab+samsung@kernel.org>
Message-ID: <CAGb2v67s29mYa+hcYFWCokmzLwi7aYyeBwDnQiTJQYxT0GxPNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 12:09 AM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> As files got renamed, their references broke.
>
> Manually fix a series of broken refs at the DT bindings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---

>  Documentation/devicetree/bindings/mfd/sun6i-prcm.txt |  2 +-

Acked-by: Chen-Yu Tsai <wens@csie.org>
