From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 6 Apr 2017 22:17:31 +0800
Subject: [PATCH 4/5] vfio: platform: Convert to use devm_*()
In-Reply-To: <10625a88-3d6d-de52-8299-3ba0031317f8@redhat.com>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
 <1490539314-9681-5-git-send-email-leo.yan@linaro.org>
 <10625a88-3d6d-de52-8299-3ba0031317f8@redhat.com>
Message-ID: <20170406141731.GA27245@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 02, 2017 at 04:45:28PM +0200, Auger Eric wrote:
> Hi Leo,
> 
> On 26/03/2017 16:41, Leo Yan wrote:
> > Convert driver to use devm_*() APIs so rely on driver model core layer
> > to manage resources. This eliminates error path boilerplate and makes
> > code neat.
> > 
> > This patch also renames amba_id structure, the old code used some code
> > which directly copied from other driver.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Looks good to me
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for reviewing, Eric.

> May be interesting to go further converting as well the vfio-platform
> driver but this can be done later on.

Looked a bit for vfio-platform driver and I'm not sure if need some
converting within function vfio_platform_probe_common(). So I'd like
to leave this to who really understand the subsystem :)

[...]

Thanks,
Leo Yan
