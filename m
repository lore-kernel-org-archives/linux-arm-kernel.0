From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 13 Jun 2016 09:37:58 -0400
Subject: [PATCH] media: s5p-mfc fix video device release double release in
 probe error path
In-Reply-To: <1465436102-13827-1-git-send-email-shuahkh@osg.samsung.com>
References: <1465436102-13827-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <CABxcv==o3od4woG6EHbc9Go0HAkFF1UmmSz-gFP3dwd9LoK0LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah,

On Wed, Jun 8, 2016 at 9:35 PM, Shuah Khan <shuahkh@osg.samsung.com> wrote:
> Fix Decoder and encoder video device double release in probe error path.
> video_device_release(dev->vfd_dec) get called twice if decoder register
> fails. Also, video_device_release(dev->vfd_enc) get called twice if encoder
> register fails.
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---

Right, thanks for the fix.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
