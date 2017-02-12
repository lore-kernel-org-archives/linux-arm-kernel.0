From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 12 Feb 2017 14:39:36 +0800
Subject: [PATCH 2/4] ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE
In-Reply-To: <20170210094133.11382-3-mylene.josserand@free-electrons.com>
References: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
 <20170210094133.11382-3-mylene.josserand@free-electrons.com>
Message-ID: <CAGb2v66jmwGCW=TwCN_9Y9uOjL603a8b0XKAH0YBXen_FSFf2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 5:41 PM, Myl?ne Josserand
<mylene.josserand@free-electrons.com> wrote:
> Update the driver to use the new SOC_DAPM_DOUBLE definition
> on the digital DAC mixer.
> Update the names accordingly as, when they are shared, the
> controls are not prefixed with the widget's name anymore.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
