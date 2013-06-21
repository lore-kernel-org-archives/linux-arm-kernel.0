From: dsd@laptop.org (Daniel Drake)
Date: Fri, 21 Jun 2013 11:36:51 -0600
Subject: [V2 7/7] video: mmp: add video layer set win/addr operations
 support
In-Reply-To: <1370879593-11557-1-git-send-email-jtzhou@marvell.com>
References: <1370879593-11557-1-git-send-email-jtzhou@marvell.com>
Message-ID: <CAMLZHHS8d3Uh=RWo3QJcamVxNrkzo8eBRWTaRACmAfz9e1NO3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 9:53 AM, Jett.Zhou <jtzhou@marvell.com> wrote:
> From: Jing Xiang <jxiang@marvell.com>
>
> Since mmp display controller support graphic/video layer together, so
> add  win/addr setting operations support when set win parameters.

> Signed-off-by: Jing Xiang <jxiang@marvell.com>
> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>

Still confused by the implementation of overlay_is_vid(), but on the
basis that overlays can be either video or graphics, the code changes
here seem to fit with the device specs.

Reviewed-by: Daniel Drake <dsd@laptop.org>
