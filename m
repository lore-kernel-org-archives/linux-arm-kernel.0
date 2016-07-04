From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Mon, 4 Jul 2016 09:59:17 +0800
Subject: [alsa-devel] [PATCH v5 7/9] ASoC: bt-sco: extend rate and add a
 general compatible string
In-Reply-To: <CAGb2v67rgj4efyTZpZ-79NnCRM=KLJCJedte594qgSjMMB5xsQ@mail.gmail.com>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-8-git-send-email-garlic.tseng@mediatek.com>
 <20160629191500.GU6247@sirena.org.uk>
 <1467291345.11091.16.camel@mtksdaap41>
 <1467341386.21689.6.camel@mtksdaap41> <20160701161105.GY6247@sirena.org.uk>
 <CAGb2v67rgj4efyTZpZ-79NnCRM=KLJCJedte594qgSjMMB5xsQ@mail.gmail.com>
Message-ID: <1467597557.11819.4.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2016-07-02 at 17:05 +0800, Chen-Yu Tsai wrote:

Hi,

> Could we also make this driver directly configurable from Kconfig,
> and not just selected by platforms (currently Samsung) or by building
> all coddecs?
> 
> Thanks
> ChenYu

I'll add configure prompt for SND_SOC_BT_SCO in next patchset.
Thanks for comment.

Garlic
