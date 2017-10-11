From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 11 Oct 2017 13:24:03 +0200
Subject: [PATCH v3 09/14] regmap: add iopoll-like polling macro for
 regmap_field
In-Reply-To: <20171004104732.jkps4ufekfizcrkz@sirena.co.uk>
References: <20170929082306.16193-1-wens@csie.org>
 <20170929082306.16193-10-wens@csie.org>
 <20171004104732.jkps4ufekfizcrkz@sirena.co.uk>
Message-ID: <20171011112403.cftnkwzlbpo5ngzc@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 11:47:32AM +0100, Mark Brown wrote:
> On Fri, Sep 29, 2017 at 04:23:01PM +0800, Chen-Yu Tsai wrote:
> > This patch adds a macro regmap_field_read_poll_timeout that works
> > similar to the readx_poll_timeout defined in linux/iopoll.h, except
> > that this can also return the error value returned by a failed
> > regmap_field_read.
> 
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
> 
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-poll-field
> 
> for you to fetch changes up to 667063acb81931e2f8fd0cb91df9fcccad131d9a:
> 
>   regmap: add iopoll-like polling macro for regmap_field (2017-10-04 11:46:32 +0100)

Pulled into drm-misc-next for 4.15 since Maxime needs that for the sun4i
changes.

Thanks, Daniel

> 
> ----------------------------------------------------------------
> regmap: Add field polling macro
> 
> ----------------------------------------------------------------
> Chen-Yu Tsai (1):
>       regmap: add iopoll-like polling macro for regmap_field
> 
>  include/linux/regmap.h | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)



> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
