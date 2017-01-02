From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 2 Jan 2017 19:09:41 -0200
Subject: [PATCH 00/20] i.MX Media Driver
In-Reply-To: <1483050455-10683-1-git-send-email-steve_longerbeam@mentor.com>
References: <1483050455-10683-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <CAOMZO5DM4aRwzCWkRoZLmbCxn155YL+CUR_gJyDh+FjzSKD3PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Thu, Dec 29, 2016 at 8:27 PM, Steve Longerbeam <slongerbeam@gmail.com> wrote:
> This is a media driver for video capture on i.MX.
>
> Refer to Documentation/media/v4l-drivers/imx.rst for example capture
> pipelines on SabreSD, SabreAuto, and SabreLite reference platforms.
>
> This patchset includes the OF graph layout as proposed by Philipp Zabel,
> with only minor changes which are enumerated in the patch header.

Patches 13, 14 and 19 miss your Signed-off-by tag.

Tested the whole series on a mx6qsabresd:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
