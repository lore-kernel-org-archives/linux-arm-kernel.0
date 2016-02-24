From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 24 Feb 2016 11:48:46 -0800
Subject: [PATCH v5 0/4] Mediatek MT2701 SCPSYS power domain support
In-Reply-To: <1455692499-56828-1-git-send-email-jamesjj.liao@mediatek.com>
 (James Liao's message of "Wed, 17 Feb 2016 15:01:35 +0800")
References: <1455692499-56828-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <7hmvqpsxcx.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James Liao <jamesjj.liao@mediatek.com> writes:

> This patchset is based on v4.5-rc4 and adds scpsys power domain support
> for Mediatek MT2701.
>
> To share the code between MT2701 and MT8173, this patchset also refined
> original mtk-scpsys.c to separate common codes and platform codes, so
> that mtk-scpsys.c can support new SoCs more easily.

Thanks for refactoring to support multiple SoCs, I like this version
much better.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
