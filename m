From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 17 May 2017 17:00:02 +0800
Subject: [PATCH v3 15/21] drm/sun4i: Ignore the generic connectors for
 components
In-Reply-To: <a766ed0410e4c78e49f1e462775fdba1a70a88bf.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
 <a766ed0410e4c78e49f1e462775fdba1a70a88bf.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66Cxb84sRoESWQbqDxpTVAVFd0vFcKz+DB2TKD83Aw1JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 3:40 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The generic connectors such as hdmi-connector doesn't have any driver in,
> so if they are added to the component list, we will be waiting forever for
> a non-existing driver to probe.
>
> Add a list of the connectors we want to ignore when building our component
> list.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
