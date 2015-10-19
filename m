From: ricard.wanderlof@axis.com (Ricard Wanderlof)
Date: Mon, 19 Oct 2015 08:56:51 +0200
Subject: [alsa-devel] [PATCH v1 1/4] ASoC: codec: Inno codec driver for
 RK3036 SoC
In-Reply-To: <1444698070-4191-2-git-send-email-zhengsq@rock-chips.com>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
 <1444698070-4191-2-git-send-email-zhengsq@rock-chips.com>
Message-ID: <alpine.DEB.2.02.1510190855250.4075@lnxricardw1.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 13 Oct 2015, Shunqian Zheng wrote:

> +static const struct of_device_id rk3036_codec_of_match[] = {
> +       { .compatible = "rk3036-codec", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, rk3036_codec_of_match);

Isn't a compatible string normally in the form "rockchip,rk3036-codec" ?

/Ricard
-- 
Ricard Wolf Wanderl?f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
