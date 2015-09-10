From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 10 Sep 2015 16:16:10 +0200
Subject: [PATCH v8 10/55] [media] media: rename the function that create
 pad links
In-Reply-To: <06bad8b26ee0cef02d9c52d578af3a51a0f03b1f.1440902901.git.mchehab@osg.samsung.com>
References: <cover.1440902901.git.mchehab@osg.samsung.com>
 <06bad8b26ee0cef02d9c52d578af3a51a0f03b1f.1440902901.git.mchehab@osg.samsung.com>
Message-ID: <CABxcv=mdyshSH5wzRRJHnhiavr_m74=Ax07=JzSTO1uxiCmJtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 30, 2015 at 5:06 AM, Mauro Carvalho Chehab
<mchehab@osg.samsung.com> wrote:
> With the new API, a link can be either between two PADs or between an interface
> and an entity. So, we need to use a better name for the function that create
> links between two pads.
>
> So, rename the such function to media_create_pad_link().
>
> No functional changes.
>
> This patch was created via this shell script:
>         for i in $(find drivers/media -name '*.[ch]' -type f) $(find drivers/staging/media -name '*.[ch]' -type f) $(find include/ -name '*.h' -type f) ; do sed s,media_entity_create_link,media_create_pad_link,g <$i >a && mv a $i; done
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
>

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
